module CMS::Liquid::Tags
  
  # TODO: document this liquid tag
  class Content < Liquid::Tag
    
    def initialize(tag_name, markup, tokens)
      @attributes = parse_attributes(markup)
      @content_name = (@attributes[:name] || 'body').strip
      @xpage = (@attributes[:xpage] || 'false').strip == 'true'
    end
  
    # Renders content area
    def render(context)
      self.context=(context)
      
      Data.content_for_page(@content_name, page.path)
    end
  end
end

Liquid::Template.register_tag(:content, CMS::Liquid::Tags::Content)
