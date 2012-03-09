require "object_templates/base"
require "object_templates/resolver"
require "object_templates/version"

module ObjectTemplates
end

Class.send :include, ObjectTemplates::ClassMethods
