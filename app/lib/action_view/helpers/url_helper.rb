module ActionView
  module Helpers
    require 'action_view/helpers/tag_helper'
    
    module UrlHelper
      def link_to(content, href, options = {})
        content_tag(:a, options.merge(:href => href))
      end
    end
  end
end
