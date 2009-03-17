require File.dirname(__FILE__) + '/../spec_helper'

describe Esvien::Repo do
  def repo
    @repo ||= Esvien::Repo.new(@path)
  end

  context "given a bad uri" do
    before do
      @path = repo_path(:not_there)
    end

    it "raises when initializing" do
      lambda { repo }.
        should raise_error(Esvien::BadRepository)
    end
  end

  context "given a good uri" do
    before do
      @path = repo_path(:empty)
    end

    it "initializes without error" do
      lambda { repo }.
        should_not raise_error
    end

    it "has a uri equal to the path we gave it" do
      repo.uri.should == @path
    end

    it "equals another Repo with the same UUID" do
      repo.should == repo
      repo.should == Esvien::Repo.new(@path)
    end

    context "to an empty repository" do
      before do
        @path = repo_path(:empty)
      end

      it "has a nil HEAD commit" do
        repo.head.should be_nil
      end

      it "has an empty commit list" do
        repo.commits.should be_empty
      end
    end

    context "to a repository with at least one commit" do
      before do
        @path = repo_path(:vanilla)
      end

      it "has a HEAD commit" do
        repo.head.should be_a(Esvien::Commit)
        repo.head.id.should == 1
        repo.head.author.should == 'donovan'
        repo.head.date.should be_close(Time.utc(2009, 3, 17, 16, 9, 35), 1)
      end

      it "has a commit list of all the commits in the repo" do
        repo.commits.should have(1).commit
      end

      it "can get a range of commits" do
        repo.commits(1..1).should == [repo.head]
      end
    end
  end
end
