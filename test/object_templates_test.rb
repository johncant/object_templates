require './test_helper'

class FooTemplate
  def initialize(c)
    @content = c
  end

  acts_as_object_template :template => :content, :resolver => Resolver

  class Resolver < ObjectTemplates::Resolver
    attr_accessor :founder
    def template_resolver
      {:website_name => "behiring"}
      {:founder => lambda do @founder end}
    end
  end

end

class ObjectTemplatesTest < ActiveSupport::TestCase
  FooTemplate

  test "template a string with one simple value" do

    tmpl = FooTemplate.new("Our website is called [[ website_name ]].")
    result = tmpl.evaluate_object_template do |r|
      # Don't need any config here
    end
    assert_equal "Our website is called behiring.", result

  end
end
