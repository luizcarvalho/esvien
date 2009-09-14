module Esvien
  class Commit
    attr_reader :id
    attr_reader :repo
    attr_accessor :author
    attr_accessor :date
    attr_accessor :msg

    include Comparable

    def initialize(id, repo)
      @id = id
      @repo = repo
      @msg = ''
    end

    def <=>(other)
      if other.is_a?(Commit)
        if self.repo == other.repo
          return id <=> other.id
        else
          raise Esvien::RepositoryMismatch
        end
      else
        raise ArgumentError, "Cannot compare #{self.class} with #{other.class}"
      end
    end

    def pretty_print(pp)
      pp.group(1, %{#<#{self.class}}, %{>}) do
        pp.breakable
        pp.seplist(%w[id repo], lambda { pp.comma_breakable }) do |attr|
          pp.text(attr)
          pp.text("=")
          pp.pp(send(attr))
        end
      end
    end

    alias_method :inspect, :pretty_print_inspect
  end
end
