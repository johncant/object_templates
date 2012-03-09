class NoTemplateGivenError < StandardError ; end
class NoResolverGivenError < StandardError ; end


module ObjectTemplates
  module Base
    def self.included(kl)
      kl.extend ObjectTemplates::ClassMethods
    end

    module InstanceMethods

      def evaluate_object_template(&block)
        resolver = self.class.class_variable_get(:@@resolver).new
        yield(resolver)
        resolver.resolve(self.instance_variable_get(self.class.class_variable_get(:@@template_attr)))
        # Rendering logic goes here:

        # Find all [[]] templates
        # find the path into the resolver
        # find and execute or copy the resolver entry

      end
     

    end

  end

  module ClassMethods

    def acts_as_object_template(options)
      include ObjectTemplates::Base::InstanceMethods

      self.send :class_variable_set, :@@template_attr, ("@"+(options[:template] || throw(NoTemplateGivenError)).to_s).to_sym
      self.send :class_variable_set, :@@resolver, (options[:resolver] || throw(NoResolverGivenError))

    end

  end
end
