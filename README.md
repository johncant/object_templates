ObjectTemplates
===============

 - Basic secure templates for web users, with the least imaginative name possible, surprisingly well written for 1am - 5:30am code.

Usage
-----

With rails

Gemfile:
```ruby
gem "object_templates"
```

Without rails
```ruby
require 'rubygems'
require 'object_templates'
```

```ruby
class FooTemplate
  def initialize(c)
    @content = c
  end

  class Resolver < ::ObjectTemplates::Resolver
    attr_accessor :cofounder1, :cofounder2

    def template_resolver
      # This method defines the objects and values allowed in the template.
      # Use lambdas because we want to cache this hash and be enumerable.

      {:website_name => "BeHiring",
       :cofounder1 => lambda do @cofounder1 end,
       :cofounder2 => {:name => lambda do @cofounder2.name end}}
    end
  end

  # content attribute is used as the actual template string
  acts_as_object_template :template => :content, :resolver => Resolver

end

tmpl = FooTemplate.new("I am [[ cofounder1.name ]], he is [[ cofounder2.name]], and our website is called [[ website_name ]].")
result = tmpl.evaluate_object_template do |r|
  # This block is used to set all the data that is used in the template objects
  r.cofounder = {:name => "John Cant"}
end
```

result should be "I am John Cant, he is Arkadiuz Turlewicz, and our website is called BeHiring"
