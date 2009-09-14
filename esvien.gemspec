Gem::Specification.new do |s|
  s.name = %q{esvien}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Donovan"]
  s.date = %q{2009-03-17}
  s.description = %q{A simple Subversion client for Ruby}
  s.email = %q{brian.donovan@gmail.com}
  s.extra_rdoc_files = ["README.md", "LICENSE"]
  s.files = ["README.md", "LICENSE", "Rakefile", "lib/esvien", "lib/esvien/commit.rb", "lib/esvien/errors.rb", "lib/esvien/repo.rb", "lib/esvien.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/eventualbuddha/esvien}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{esvien}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A simple Subversion client for Ruby}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<hpricot>, [">= 0.6"])
    else
      s.add_dependency(%q<hpricot>, [">= 0.6"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0.6"])
  end
end
