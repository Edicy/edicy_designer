module CMS::Liquid::Tags

  # Will generate add-to-menu link. If this link is clicked, it will show small popup on screen to enter details for new
  # page.
  #
  # == Attributes
  #
  # If you want this link to produce sub-pages for pages you can pass the optional "parent" parameter such as this
  #
  #  {% for item in site.menuitems %}{{ item.title }}{% menuadd parent="item" %}{% endfor %}
  #
  class Menuadd < Liquid::Tag
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::AssetTagHelper
    include ActionView::Helpers::UrlHelper
    
    Syntax = /(#{Liquid::VariableSignature}+)/
    
    def initialize(tag_name, markup, tokens)
      @attributes = parse_attributes(markup)
    end
    
    def render(context)
      self.context=(context)
      ''
    end
  end
end

Liquid::Template.register_tag(:menuadd, CMS::Liquid::Tags::Menuadd)
