module CMS::Liquid::Tags
  
  # Generates comment form for blog/news article. Form is generated by default for variable named "article"
  #
  #  {% commentform %}form contents{% endcommentform %}
  #  => <form action="article_comments_url" method="post">form contents</form>
  #
  # If variable named "article" is missing from scope (for example in for-loops, where variable name is something else),
  # you can specify article variable name explicitly:
  #
  #  {% commentform article="some_other_article" %}form_contents{% endcommentform %}
  #  => <form action="article_comments_url" method="post">form contents</form>
  #
  # If article has not yet been saved, it is possible to turn on displaying the comment form:
  #
  #  {% commentform shownew="true" %}form contents{% endcommentform %}
  # 
  # will not output anything unless article is already saved.
  #
  # == Attributes
  #
  # article:: Optional. Set variable name for article explicitly
  # skipnew:: Optional. If set to 'true' comment form will be skipped for new (unsaved) articles.
  class CommentForm < Liquid::Block
    
    VariableSignature = /\(?[\w\-\.\[\]\/]\)?/
    Syntax = /(#{VariableSignature}+)/
    
    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @attributes = parse_attributes(markup)
      else
        @attributes = {:article => 'article', :skipnew => false}
      end
      super
    end
    
    def render(context)
      self.context=(context)
      variable_name = @attributes[:article] || 'article'
      show_new = @attributes[:shownew] ? @attributes[:shownew] == 'true' : false

      article = context[variable_name]
      
      return if render_static? or article.nil? or article.new_record? and not show_new
      
      output = super
      
      result = "<form action=\"#{article.comments_url}\" method=\"post\">"
      result << output.to_s
      result << '<div style="display:none; visibility:hidden;">'
      result << "Email again:"
      result << '</div>'
      result << '</form>'
      
      result
    end
    
  end
end

Liquid::Template.register_tag(:commentform, CMS::Liquid::Tags::CommentForm)
