require 'htmlentities'

module ReplaceEntities
  module ArExtend
    # Strips ASCII control chars from attributes before they get saved
    def replace_entities!(options = nil)
      before_validation do |record|
        attributes = ReplaceEntities::ArExtend.narrow(record.attributes, options)
        attributes.each do |attr, value|
          if value.is_a?(String)
            coder = HTMLEntities.new
            record[attr] = coder.decode(value)
          end
        end
      end
    end

    # Necessary because Rails has removed the narrowing of attributes using :only
    # and :except on Base#attributes
    def self.narrow(attributes, options)
      if options.nil?
        attributes
      else
        if except = options[:except]
          except = Array(except).collect { |attribute| attribute.to_s }
          attributes.except(*except)
        elsif only = options[:only]
          only = Array(only).collect { |attribute| attribute.to_s }
          attributes.slice(*only)
        else
          raise ArgumentError, "Options does not specify :except or :only (#{options.keys.inspect})"
        end
      end
    end
  end
end
