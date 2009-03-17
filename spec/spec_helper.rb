require 'spec'
$LOAD_PATH.push File.dirname(__FILE__) + '/../lib'
require 'esvien'

Spec::Runner.configure do |config|
  SUBVERSION_REPOSITORY_URL = "http://svn.collab.net/repos/svn/trunk/"

  def repo_path(name)
    "file://#{File.expand_path(File.dirname(__FILE__) + "/fixtures/repos/#{name}")}"
  end

  def repo_by_name(name)
    Esvien::Repo.new(repo_path(name))
  end
end
