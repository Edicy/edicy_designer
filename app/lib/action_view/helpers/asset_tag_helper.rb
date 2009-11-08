module ActionView
  module Helpers
    require 'action_view/helpers/tag_helper'
    
    module AssetTagHelper
      def image_tag(image, options)
        "<img src=\"#{image}\"#{tag_options(options)}/>"
      end
      
      def auto_discovery_link_tag(type = :rss, url_options = '', tag_options = {})
        content_tag(
          "link",
          "rel"   => tag_options[:rel] || "alternate",
          "type"  => tag_options[:type] || "application/xml",
          "title" => tag_options[:title] || type.to_s.upcase,
          "href"  => url_options
        )
      end
    end
  end
end
