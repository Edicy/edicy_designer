module CMS::Liquid::Tags
  
  # Generates link to login window. Block can contain other liquid code.
  #
  #   {% loginblock %}{% image 'login_here.gif' %}{% endloginblock %}
  #   #=> <a href="#" onclick="login logic"><img src="/images/login_here.gif" /></a>
  #
  class Loginblock < Liquid::Block
    
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::CaptureHelper
    
    attr_accessor :output_buffer
    
    Syntax = /(#{Liquid::QuotedFragment}+)/
    
    def initialize(tag_name, markup, tokens)
      super
    end
    
    def render(context)
      self.context=(context)
      output = super
      
      href = "http://www.edicy.com"
      
      "<a href=\"http://www.edicy.com\">#{output}</a>"
    end
  end
end

Liquid::Template.register_tag(:loginblock, CMS::Liquid::Tags::Loginblock)
