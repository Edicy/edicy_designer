module CMS::Liquid::Tags
  
  # This tag makes value of an object editable when CMS session is active.
  #
  # == Basic usage.
  #
  #   {% editable object.field %}
  #
  # == Available attributes
  #
  # basic_editor:: Defaults to "false" and generates rich text editor. Set to "true" if you want plain text editor
  # object:: Object name to use in form element names
  # method:: Object method name to use in form element names
  # 
  class Editable < Liquid::Tag
    
    Syntax = /(#{Liquid::VariableSignature}+)/
    
    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @variable_name = $1
      else
        raise SyntaxError.new("Syntax Error in 'editable' - Valid syntax: editable item_name")
      end
      super
    end
  
    # Wraps object into editable area.
    def render(context)
      self.context=(context)
      
      context[@variable_name]
    end
  end
end

Liquid::Template.register_tag(:editable, CMS::Liquid::Tags::Editable)
