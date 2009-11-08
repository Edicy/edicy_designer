# Extend Liquid tag with functions to ease up writing cms tags
module Liquid
  
  # TODO: enable argument matching from single quotes and without quotes
  Attributes = /(\w+)\s*\=\s*"([^"]+)"/
  
  class Tag
    attr_writer :context
    
    # Content renderer
    def content_renderer
      @context.registers[:content_renderer]
    end
  end
end

module CMS; end

module CMS::Liquid
  # Module to extend Liquid tag and drop objects with extra convenience helper methods
  module Extensions
    
    module InstanceMethods
      
      def parse_attributes(markup)
        attributes = {}
        markup.scan(Liquid::Attributes) do |key, value|
          attributes[key.to_sym] = value
        end
        attributes
      end
    end
    
    module ClassMethods
      
      protected
        def current_working_language
          @context.registers[:current_working_language]
        end
      
        def current_page_id
          @context['page'].page_id
        end
        
        def current_language_id
          @context['page'].language_id
        end
        
        def page
          @context['page']
        end
        
        def site
          @context['site']
        end
        
        # Returns relative path to application root. For example if application is hosted at http://localhost/myapp,
        # this method returns myapp
        def relative_url_root
          @context.registers[:relative_url_root]
        end
        
        # Returns true if admin session is currently active
        def cmssession?
          @context.registers[:cmssession?]
        end
        
        # Returns true if user is in edit mode
        def editing?
          @context.registers[:editing?]
        end
        
        def show_unpublished_content?
          @context.registers[:show_unpublished_content?]
        end
        
        # Returns true if rendering static pages. This is used when downloading an site and pages are being rendered as
        # .html files.
        def render_static?
          @context.registers[:render_static?]
        end

        # Returns form authenticity token.
        def authenticity_token
          @context.registers[:authenticity_token]
        end
        
        # Return hostname used on request.
        def host
          @context.registers[:host]
        end
        
        # Return hostname with port used on request.
        def host_with_port
          @context.registers[:host_with_port]
        end
        
        # Return request protocol -- whether http:// or https://
        def protocol
          @context.registers[:protocol]
        end
        
        # Register object in context as editable on page. These objects are later used to generate wrapper Javascript
        # objects on page to handle save events.
        # DEPRECATED
        def register_editable(editable)
          @context.registers[:editables] << editable unless @context.registers[:editables].include?(editable)
        end
    end
  end
end

Liquid::Tag.send(:include, CMS::Liquid::Extensions::ClassMethods)
Liquid::Tag.send(:include, CMS::Liquid::Extensions::InstanceMethods)
Liquid::Drop.send(:include, CMS::Liquid::Extensions::ClassMethods)
Liquid::Drop.send(:include, CMS::Liquid::Extensions::InstanceMethods)

module CMS::Liquid::Filters; end

require "#{File.dirname(__FILE__)}/liquid/cms_file_system.rb"

# Load custom filters for Edicy
require "#{File.dirname(__FILE__)}/liquid/filters/localization_filters.rb"
require "#{File.dirname(__FILE__)}/liquid/filters/standard_filters.rb"

# Load custom tags for Edicy
%w(
  blog_context comment_form content editable elements_context grouped image languageadd load login loginblock menuadd
  menulink rss_link stylesheet_link url_include x_content
).each do |tag|
  require "#{File.dirname(__FILE__)}/liquid/tags/#{tag}.rb"
end
