module CMS::Liquid::Tags
  
  # TODO: document this liquid tag
  class XContent < Content
    
    def initialize(tag_name, markup, tokens)
      @attributes = parse_attributes(markup)
      @content_name = (@attributes[:name] || 'body').strip
      @xpage = true
    end
  
  end
end

Liquid::Template.register_tag(:xcontent, CMS::Liquid::Tags::XContent)
