module CMS::Liquid::Tags

  # Loads specific types of objects and assigns them into a variable that is accessible in template. Valid types of
  # objects are:
  #
  # mediaset::  Returns first mediaset found by attributes or no object when it cannot find any
  # mediasets:: Returns list of mediasets found by the attributes or empty list if none match
  #
  # == Examples
  #
  #   {% load mediaset to "set" title="Foobar" %}
  #   {{ mediaset.title }}
  #   #=> Foobar
  #
  class Load < Liquid::Tag
    
    Syntax = /(mediaset|mediasets)\s+to\s+"([\w\-\_]+)"/
    
    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @object_type = $1
        @to = $2
        @attributes = parse_attributes(markup)
      else
        raise SyntaxError.new("Syntax Error in 'load' - Valid syntax: load object_type to \"variable\" attribute=\"value\" ...")
      end
      super
    end
    
    def render(context)
      context.scopes.last[@to.to_s] = case @object_type.to_sym
      when :mediaset
        load_mediaset
      when :mediasets
        load_mediasets
      end
      
      ''
    end
    
    private
    
    # Load single mediaset by requested attributes.
    def load_mediaset
      nil
    end

    # Loads list of mediasets by optionally filtering them by requested attributes
    def load_mediasets
      []
    end
  end
end

Liquid::Template.register_tag(:load, CMS::Liquid::Tags::Load)
