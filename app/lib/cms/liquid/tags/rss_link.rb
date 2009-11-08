module CMS::Liquid::Tags
  
  # Generates LINK tag for RSS-feed. Use inside HEAD tag
  #
  #   {% rss_link %}
  #   #=> <link rel="alternate" type="application/rss+xml" title="RSS" href="url/to/rss/file">
  #
  class RssLink < Liquid::Tag
    include ActionView::Helpers::AssetTagHelper
    include ActionView::Helpers::TagHelper
    
    def render(context)
      self.context=(context)
      
      auto_discovery_link_tag(:rss, "index.rss", {:title => 'RSS Feed'})
    end
  end
end

Liquid::Template.register_tag(:rss_link, CMS::Liquid::Tags::RssLink)
