module ActionView
  module Helpers
    module TagHelper
      
      BOOLEAN_ATTRIBUTES = %w(disabled readonly multiple checked).to_set
      
      def content_tag(tag_name, options, &block)
        if block_given?
          output = "<#{tag_name}#{tag_options(options)}>"
          output << yield
          output << "</#{tag_name}>"
        else
          output = "<#{tag_name}#{tag_options(options)} />"
        end
      end
      
      def tag_options(options, escape = true)
        unless options.empty?
          attrs = []
          if escape
            options.each_pair do |key, value|
              if BOOLEAN_ATTRIBUTES.include?(key)
                attrs << %(#{key}="#{key}") if value
              else
                attrs << %(#{key}="#{value}") if !value.nil?
              end
            end
          else
            attrs = options.map { |key, value| %(#{key}="#{value}") }
          end
          " #{attrs.sort * ' '}" unless attrs.empty?
        end
      end
    end
  end
end
