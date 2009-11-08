module CMS::Liquid::Tags
  
  # Generates link to login window
  #
  #   {% login %}
  #   #=> <a href="#" onclick="login logic">edit</a>
  #
  #   {% login "change me" %}
  #   #=> <a href="#" onclick="login logic">change me</a>
  #
  class Login < Liquid::Tag

    Syntax = /(#{Liquid::QuotedFragment}+)/
    
    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @label = $1.gsub(/^"|^'|"$|'$/, '')
      else
        @label = 'edit'
      end
      super
    end
    
    def render(context)
      self.context=(context)
      
      href = "http://www.edicy.com"
      
      "<a href=\"http://www.edicy.com\">#{@label}</a>"
    end
  end
end

Liquid::Template.register_tag(:login, CMS::Liquid::Tags::Login)
