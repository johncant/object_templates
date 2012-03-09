module ObjectTemplates

  class TemplateResolverUndefinedError < StandardError ; end
  class InvalidCodeError < StandardError ; end
  class InvalidResolverEntryError < StandardError ; end

  class Resolver
    def initialize
      @template_resolver = template_resolver
    end

    def template_resolver
      raise TemplateResolverUndefined
    end

    def self.evaluate_template_resolver_entry(entry)
      if entry.kind_of?(Hash) || entry.kind_of?(String)
        entry
      elsif entry.kind_of? Proc
        entry.call
      else
        raise InvalidResolverEntryError
      end
    end

    def resolve(template)
      # Find everything between pairs of [[ ]]
      template.gsub(/\[\[[^\[\]]*\]\]/) do |tmpl|
        # Get rid of the brackets
        tmpl = tmpl.gsub(/[\[\]\s]/, "")
        # Check the expression
        code = tmpl.split(".")
        code.each do |t|
          raise InvalidCodeError unless t.match(/[\w]+/)
        end
        # The code must be valid
        # 
        resolve_hash = @template_resolver
        code.each do |c|
          resolve_hash = Resolver.evaluate_template_resolver_entry(resolve_hash[c.to_sym])
        end
        raise InvalidCodeError unless resolve_hash.kind_of? String
        resolve_hash
      end
    end
  end
end
