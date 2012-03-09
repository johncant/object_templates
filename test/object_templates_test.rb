require 'rubygems'
require 'test/unit'
require 'object_templates'


class FooTemplate
  def initialize(c)
    @content = c
  end


  class Resolver < ::ObjectTemplates::Resolver
    attr_accessor :cofounder
    def template_resolver
      {:website_name => "BeHiring",
       :cofounder => lambda do @cofounder end}
    end
  end

  acts_as_object_template :template => :content, :resolver => Resolver

end

class ObjectTemplatesTest < Test::Unit::TestCase

  def test_object_templating

    tmpl = FooTemplate.new("I am [[ cofounder.name ]] and our website is called [[ website_name ]].")
    result = tmpl.evaluate_object_template do |r|
      # Don't need any config here
      r.cofounder = {:name => "John Cant"}
    end
    assert_equal "I am John Cant and our website is called BeHiring.", result

  end
end
