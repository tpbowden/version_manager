$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require "version_manager/version"

Gem::Specification.new do |s|
  s.name                  = "version_manager"
  s.version               = VersionManager::VERSION
  s.summary               = "Convenience tasks for version management"
  s.description           = "Increment your project's version and history file automatically"
  s.authors               = ["Tom Bowden"]
  s.email                 = "tom.b1992@gmail.com"
  s.files                 = Dir["README.md", "lib/**/*"]
  s.homepage              = "http://github.com/tpbowden/version_manager.git"
  s.license               = "MIT"
  s.required_ruby_version = ">= 2.2.0"

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rake", "~> 12.0"
  s.add_development_dependency "simplecov", "~> 0.12"
  s.add_development_dependency "rubocop", "~> 0.47"
  s.add_development_dependency "cucumber", "~> 2.4"
end
