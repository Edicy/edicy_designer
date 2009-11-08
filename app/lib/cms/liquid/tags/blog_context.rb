module CMS::Liquid::Tags

  # Executes block template in context of blog given. Blog will be identified by it's path in site structure.
  #
  #   {% blogcontext "my_blog" %}{{ blog.rss_url }}{% endblogcontext %}
  #   => /my_blog.rss
  #
  # If you use this block on blog layout or blog article layout, using blog variable outside of this block will act as
  # normal blog associated with this page
  #
  #   {% blogcontext "another_blog" %}{{ blog.rss_url }}{% endblogcontext %} - {{ blog.rss_url }}
  #   => /another_blog.rss - /current_blog.rss
  #
  # If blog is not found from given address or page with this address is not a blog page, it will not evaluate block.
  class BlogContext < Liquid::Block
    
    Syntax = /(#{Liquid::QuotedFragment}+)/
    
    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @path = $1.gsub(/^"|^'|"$|'$/, '')
      end
      super
    end
    
    def render(context)
      self.context=(context)

      # TODO: find a blog in here
      super
    end
  end
end

Liquid::Template.register_tag(:blogcontext, CMS::Liquid::Tags::BlogContext)
