module CMS::Liquid::Tags

  # Executes block of template where list of requested elements is available. Additional element query parameters can be
  # supplied with tag attributes.
  #
  # For example if your elements have properties "name" and "awarded_product" and you want to only show awarded elements
  # with name "Cowbell":
  #
  #   {% elementscontext awarded_product="1" name="Cowbell" %}...{% endelementscontext %}
  #
  # == Optional fixed parameters:
  #
  # edicy_page_path_prefix:: Display only elements associated with page whose path starts with given path
  # element_definition:: (not implemented) Name of element such as "Product"
  # 
  # TODO: sellise päringu võiks defineerida hoopiski "virtuaalses" elementide kollektsioonis, mida saab siis konfigureerida admin alt.
  class ElementsContext < Liquid::Block
    
    Syntax = /(#{Liquid::QuotedFragment}+)/
    
    def initialize(tag_name, markup, tokens)
      super
    end
    
    def render(context)
      self.context=(context)
      
      @context['elements']
    end
  end
end

Liquid::Template.register_tag(:elementscontext, CMS::Liquid::Tags::ElementsContext)
