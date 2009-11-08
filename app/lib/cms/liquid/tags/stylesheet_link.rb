module CMS::Liquid::Tags
  
  # Generates LINK tag for stylesheet file. Use inside HEAD tag
  #
  #   {% stylesheet_link "style.css" %}
  #   #=> <link href="stylesheets/style.css" type="text/css" rel="stylesheet" media="screen" />
  #
  # To generate link tag for print media
  #
  #   {% stylesheet_link "print.css" media="print" %}
  #   #=> <link href="stylesheets/print.css" type="text/css" rel="stylesheet" media="print" />
  #
  # To generate link from static host
  #
  #   {% stylesheet_link "files/style.css" static_host="true" %}
  #   #=> <link href="http://static.edicy.com/files/style.css" type="text/css" rel="stylesheet" media="screen" />
  #
  class StylesheetLink < Liquid::Tag
    VariableSignature = /\(?[\w\-\.\[\]\/\?\=\&]\)?/
    Syntax = /(#{VariableSignature}+)/
    
    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @stylesheet = $1
        
        @attributes = parse_attributes(markup)
        @media = (@attributes[:media] || 'screen').strip
        @static_host = @attributes[:static_host] ? @attributes[:static_host] == 'true' : false
      else
        raise SyntaxError.new("Syntax Error in 'stylesheet_link' - Valid syntax: stylesheet_link \"somestyle.css\" attribute=\"value\" ...")
      end
      super
    end
    
    def render(context)
      self.context=(context)

      "<link href=\"#{stylesheet_path}\" media=\"#{@media}\" rel=\"stylesheet\" type=\"text/css\" />"
    end
    
    private

      def stylesheet_path
        case
        when @static_host
          [site.static_asset_host, @stylesheet] * '/'
        else
          [@context['stylesheets_path'], @stylesheet] * '/'
        end
      end
  end
end

Liquid::Template.register_tag(:stylesheet_link, CMS::Liquid::Tags::StylesheetLink)
