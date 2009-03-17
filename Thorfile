require 'rubygems'
require 'rubygems/specification'
require 'thor/tasks'

GEM = "esvien"
GEM_VERSION = "0.0.1"
AUTHOR = "Brian Donovan"
EMAIL = "brian.donovan@gmail.com"
HOMEPAGE = "http://github.com/eventualbuddha/esvien"
SUMMARY = "A simple Subversion client for Ruby"
PROJECT = "esvien"

SPEC = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.md", "LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.rubyforge_project = PROJECT

  s.require_path = 'lib'
  s.files = s.extra_rdoc_files + %w(Rakefile) + Dir.glob("{lib,specs}/**/*")
end

class Default < Thor
  # Set up standard Thortasks
  spec_task(Dir["spec/**/*_spec.rb"])
  install_task SPEC

  desc "gemspec", "make a gemspec file"
  def gemspec
    File.open("#{GEM}.gemspec", "w") do |file|
      file.puts SPEC.to_ruby
    end
  end
end
