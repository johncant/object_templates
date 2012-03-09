module ObjectTemplates
  module Base
    def self.included(kl)
      kl.extend ObjectTemplates::ClassMethods
    end

    module InstanceMethods

       def render(&block)
        resolver = self::Resolver.new.template_resolver
        yield(resolver)
        # Rendering logic goes here:

        # Find all [[]] templates
        # find the path into the resolver
        # find and execute or copy the resolver entry

      end
     

    end

  end

  module ClassMethods

    def object_template
      include ObjectTemplates::Base::InstanceMethods
      extend ObjectTemplates::Base::ClassMethods

      validates :body, :presence => true
      

    end

  end
end
