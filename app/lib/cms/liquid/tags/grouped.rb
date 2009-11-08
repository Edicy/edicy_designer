module CMS::Liquid::Tags

  #
  #
  #   {% grouped articles by page in site.latest_articles %}
  #     {% for article_group in articles %}
  #       {{ article_group.page.title }}
  #       {% for article in article_group.articles %}
  #       {% endfor %}
  #     {% endfor %}
  #   {% endgrouped %}
  #
  #
  #   {% grouped element_groups by region in elements %}
  #     {% for group in element_groups %}
  #       {{ group.region }}
  #       {% for element in group %}
  #         {{ element.title }}
  #       {% endfor %}
  #     {% endfor %}
  #   {% endgrouped %}
  #
  class Grouped < Liquid::Block
    
    Syntax = /(\w+)\s+by\s+(\w+)\s+in\s(#{Liquid::Expression}+)\s*/
    
    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @groups_name = $1
        @property_name = $2
        @collection_name = $3
      else
        raise SyntaxError.new("Syntax Error in 'grouped' - Valid syntax: grouped [groups] by [property] in [collection]")
      end
      
      super
    end
    
    def render(context)
      self.context=(context)

      collection = context[@collection_name]

      return '' unless collection.respond_to?(:each)
      
      grouped_hash = collection.inject(Hash.new) do |h, item|
        if item.respond_to?(@property_name.to_sym)
          property = item.send(@property_name.to_sym)
          
          h[property] = Array.new unless h[property]
          h[property] << item
          h
        else
          h
        end
      end
      
      context[@groups_name] = grouped_hash.values

      super
    end
    
  end
end

Liquid::Template.register_tag(:grouped, CMS::Liquid::Tags::Grouped)
