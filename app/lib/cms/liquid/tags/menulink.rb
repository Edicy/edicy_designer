module CMS::Liquid::Tags
  
  # Generates link to site page. Use it with variables available from <code>site.menuitems</code> array:
  #
  #   {% for item in site.menuitems %}{% menulink item %}{% endfor %}
  #   #=> <a href="/site_root/company">Company</a><a href="/site_root/contact">Contact information</a>
  #
  # == Attributes
  #
  # TODO: document attributes section
  class Menulink < Liquid::Tag
    include ActionView::Helpers::UrlHelper
    
    Syntax = /(#{Liquid::VariableSignature}+)/
    
    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @variable_name = $1
        @attributes = parse_attributes(markup)
      else
        raise SyntaxError.new("Syntax Error in 'menulink' - Valid syntax: menuitem item_name")
      end
      super
    end
    
    def render(context)
      link_to context[@variable_name].title, context[@variable_name].url
    end
  end
  
  # {% menulevel level="1" around_tag="li" between=" | " active_class="active" active_around_class="active_around" %}
  # class MenuLevel < Liquid::Tag
  # end
end

Liquid::Template.register_tag(:menulink, CMS::Liquid::Tags::Menulink)
