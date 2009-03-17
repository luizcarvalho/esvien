module Esvien
  class Error < RuntimeError
  end

  class BadRepository < Error
    attr_reader :repo

    def initialize(repo)
      @repo = repo
    end

    def message
      "No repository found at #{repo.uri}"
    end
  end

  class CLIError < Error
    def initialize(command, output)
      @command, @output = command, output
    end

    def message
      "Error while executing Subversion command:\n\n    #{@command}\n\nOutput:\n\n#{@output.to_a.map{|line|"    #{line}"}}"
    end
  end

  class RepositoryMismatch < Error
  end
end
