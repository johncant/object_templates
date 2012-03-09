$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "object_templates/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "object_templates"
  s.version     = ObjectTemplates::VERSION
  s.authors     = ["John Cant", "Arkadiusz Turlewicz"]
  s.email       = ["a.johncant@gmail.com", "arekt@gmail.com"]
  s.homepage    = "www.behiring.com"
  s.summary     = "templating gem"
  s.description = "gem for allowing users to make fairly simple templates. This is used for bulk emailing"


  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "sqlite3"
end
