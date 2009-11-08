module ActionView #:nodoc:
  module Helpers #:nodoc:
    require 'action_view/helpers/asset_tag_helper'
    require 'action_view/helpers/capture_helper'
    require 'action_view/helpers/form_tag_helper'
    require 'action_view/helpers/tag_helper'
    require 'action_view/helpers/url_helper'

    include AssetTagHelper
    include CaptureHelper
    include FormTagHelper
    include TagHelper
    include UrlHelper
  end
end
