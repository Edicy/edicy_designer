require 'net/http'
require 'uri'

module CMS::Liquid::Tags
  
  # Loads and includes content from given url.
  #
  # {% url_include url="http://someurl.com/some_data" %}
  #  => Contents from given url
  # 
  # If request fails, it is possible to display custom message:
  #
  # {% url_include url="http://invalid.url" rescue_with="Data is currently unavailable" %}
  #  => Data is currently unavailable
  #
  # == Attributes
  #
  # url:: Required. URL where contents to include from
  # rescue_with:: If request to given url fails (i.e. does not respond with 200 OK status), show this message
  class UrlInclude < Liquid::Tag
    
    def initialize(tag_name, markup, tokens)
      @attributes = parse_attributes(markup)
      @url = @attributes[:url].strip
      @rescue_with = (@attributes[:rescue_with] || '')
    end
    
    def render(context)
      self.context=(context)
      
      # TODO: Add timeout feature.
      url = URI.parse(@url)
      req = Net::HTTP::Get.new(url.path)
      res = Net::HTTP.start(url.host, url.port) do |http|
        http.request(req)
      end
      
      if res.code == '200'
        res.body
      else
        @rescue_with
      end
    rescue
      @rescue_with
    end
    
  end
end

Liquid::Template.register_tag(:url_include, CMS::Liquid::Tags::UrlInclude)
