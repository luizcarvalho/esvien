module Esvien
  class Commit
    attr_reader :id
    attr_reader :repo
    attr_accessor :author
    attr_accessor :date

    include Comparable

    def initialize(id, repo)
      @id = id
      @repo = repo
    end

    def <=>(other)
      raise ArgumentError, "Cannot compare #{self.class} with #{other.class}" unless other.is_a?(Commit)
      raise Esvien::RepositoryMismatch unless repo == other.repo
      id <=> other.id
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
