module CMS::Liquid::Filters::LocalizationFilters
  
  def lc(input)
    Data.db.i18n[input]
  end
        
  def ls(input)
    Data.db.i18n[input]
  end
end

Liquid::Template.register_filter(CMS::Liquid::Filters::LocalizationFilters)
