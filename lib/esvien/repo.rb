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

      doc = svnxml(:log, '-r', range || '1:HEAD', uri)
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

    private

    def get_repository_info
      begin
        doc = svnxml(:info, uri)
        entry = doc.at('/info/entry')
        @revision = entry.attributes['revision'].to_i
        repo = entry.at('repository')
        @uuid = repo.at('uuid').inner_text
      rescue Esvien::CLIError
        raise Esvien::BadRepository, self
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
