$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "trackable-click/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "trackable-click"
  s.version     = TrackableClick::VERSION
  s.authors     = ["Christopher Parratto"]
  s.email       = ["cparratto@gmail.com"]
  s.homepage    = "https://www.github.com/cparratto/trackable-click"
  s.summary     = "Trackable click allows you to attach fb pixels and google events as clickable items in rails"
  s.description = "Currently only provides a form helper for submit tags."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.16"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "mocha"
end
