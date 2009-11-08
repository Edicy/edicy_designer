module CMS::Liquid::Tags

  # Will generate add-new-language link. If this link is clicked, it will show small popup on screen to enter details
  # for language.
  class Languageadd < Liquid::Tag
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::AssetTagHelper
    include ActionView::Helpers::UrlHelper
    
    Syntax = /(#{Liquid::VariableSignature}+)/
    
    def initialize(tag_name, markup, tokens)
      @attributes = parse_attributes(markup)
    end
    
    def render(context)
      self.context=(context)
      if editing?
        if @attributes[:parent]
          parent = context[@attributes[:parent].to_s]
        else
          parent = @context['site'].root_item
        end
        
        CMS::Localization.with_language current_working_language do
          link_to [image_tag("#{relative_url_root}/images/admin/ico/ico-add.png", :border => 0), I18n.t('app.languages.form.add')] * ' ', "#{relative_url_root}/admin/settings/languages/new?from_page=1", :class => 'fci-editor-langadd', :onclick => 'return false;'
        end
      end
    end
  end
end

Liquid::Template.register_tag(:languageadd, CMS::Liquid::Tags::Languageadd)
