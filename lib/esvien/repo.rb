module Esvien
  class Repo
    attr_reader :uri
    attr_reader :uuid

    def initialize(uri)
      @uri = uri
      get_repository_info
    end

    def commits(range=nil)
      return [] if @revision == 0

      doc = svnxml(:log, '-r', svn_range_string(range) || '1:HEAD', uri)
      elems = doc.search('/log/logentry')
      elems.map do |elem|
        commit = Commit.new(elem.attributes['revision'].to_i, self)
        commit.author = elem.children_of_type('author').first.inner_text
        commit.date = Time.parse(elem.children_of_type('date').first.inner_text)
        commit
      end
    end

    def head
      commits('HEAD').first
    end

    def ==(other)
      uuid == other.uuid
    end

    def pretty_print(pp)
      pp.group(1, %{#<#{self.class}}, %{>}) do
        pp.breakable
        pp.seplist(%w[uri uuid], lambda { pp.comma_breakable }) do |attr|
          pp.text(attr)
          pp.text("=")
          pp.pp(send(attr))
        end
      end
    end

    alias_method :inspect, :pretty_print_inspect

    private

    def get_repository_info
      begin
        doc = svnxml(:info, uri)
        entry = doc.at('/info/entry')
        @revision = entry.attributes['revision'].to_i
        repo = entry.children_of_type('repository').first
        @uuid = repo.children_of_type('uuid').first.inner_text
      rescue Esvien::CLIError
        raise Esvien::BadRepository, self
      end
    end

    def svn_range_string(range)
      case range
      when nil
        return nil
      when Range
        "#{range.first}:#{range.last}"
      else
        range.to_s
      end
    end

    def svnxml(operation, *args)
      Hpricot.XML(svn(operation, '--xml', *args))
    end

    def svn(operation, *args)
      command = %{svn #{operation} #{args.map{|arg| %{"#{arg.to_s.gsub('"', '\"')}"}}.join(' ')} 2>&1}
      output = %x{#{command}}
      if $?.exitstatus == 0
        return output
      else
        raise Esvien::CLIError.new(command, output)
      end
    end
  end
end
