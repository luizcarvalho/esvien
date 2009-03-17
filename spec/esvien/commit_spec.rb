require File.dirname(__FILE__) + '/../spec_helper'

describe Esvien::Commit do
  it "is initialized with the revision number and repo" do
    @commit = Esvien::Commit.new(10101, repo_by_name(:vanilla))
    @commit.id.should == 10101
    @commit.repo.should == repo_by_name(:vanilla)
  end

  it "can set/get author" do
    @commit = Esvien::Commit.new(10101, repo_by_name(:vanilla))
    @commit.author = 'donovan'
    @commit.author.should == 'donovan'
  end

  it "can set/get date" do
    @commit = Esvien::Commit.new(10101, repo_by_name(:vanilla))
    @commit.date = Time.now
    @commit.date.should be_close(Time.now, 1)
  end

  context "comparisons" do
    context "between commits from the same repository" do
      before do
        @first = Esvien::Commit.new(1, repo_by_name(:vanilla))
        @last = Esvien::Commit.new(10101, repo_by_name(:vanilla))
      end

      it "implements lt" do
        @first.should < @last
        @last.should_not < @first
      end

      it "implements lte" do
        @first.should <= @last
      end

      it "implements gt" do
        @last.should > @first
      end

      it "implements gte" do
        @last.should >= @first
      end

      it "raises when comparing with something that is not a commit" do
        lambda { @first > nil }.
          should raise_error(ArgumentError)
      end
    end

    context "between commits from different repositories" do
      before do
        @a = Esvien::Commit.new(1, repo_by_name(:empty))
        @b = Esvien::Commit.new(1, repo_by_name(:vanilla))
      end

      it "raises" do
        lambda { @a > @b }.
          should raise_error(Esvien::RepositoryMismatch)
      end
    end
  end
end
