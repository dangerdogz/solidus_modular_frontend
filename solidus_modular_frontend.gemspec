$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "solidus_modular_frontend/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "solidus_modular_frontend"
  s.version     = SolidusModularFrontend::VERSION
  s.authors     = ["Gregor MacDougall"]
  s.email       = ["gregor@solidus.io"]
  s.homepage    = "https://github.com/solidusio/solidus"
  s.summary     = "Modular Front End for Solidus.io"
  s.description =
"""
  This provides a modular front end of which you can include multiple components
  in order to create your own front end for your store.
"""

  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "solidus_auth_devise"
  s.add_dependency "solidus_core", [">= 1.2.0", "< 2"]

  s.add_development_dependency "rspec", [">= 3.4.0", "< 4"]
end
