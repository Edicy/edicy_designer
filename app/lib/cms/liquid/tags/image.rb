module CMS::Liquid::Tags
  
  # Generates HTML IMG tag for given image path. Site root prefix will be added automatically.
  # Additional attributes may be supplied.
  #
  #   {% image 'images/image_path.png' %}
  #   #=> <img src="/site_root/images/image_path.png" />
  #
  # == Attributes
  #
  # All attributes after image path will copied onto IMG tag attributes:
  #
  #   {% image 'image_path.png' alt="Image" foo="Bar" %}
  #   #=> <img src="/site_root/image_path.png" alt="Image" foo="Bar" />
  #
  class Image < Liquid::Tag
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::AssetTagHelper
    
    VariableSignature = /\(?[\w\-\.\[\]\/]\)?/
    Syntax = /(#{VariableSignature}+)/
    
    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @variable_name = $1
        @attributes = parse_attributes(markup)
      else
        raise SyntaxError.new("Syntax Error in 'image' - Valid syntax: image \"image_path\" attribute=\"value\" ...")
      end
      super
    end
    
    def render(context)
      image_tag "#{context['site_path']}/#{@variable_name}", @attributes
    end
  end
end

Liquid::Template.register_tag(:image, CMS::Liquid::Tags::Image)
