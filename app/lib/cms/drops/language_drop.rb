class LanguageDrop < Liquid::Drop

  def initialize(lang, current_page)
    @language = lang
    @current_page = current_page
  end
  
  def id
    @language.id
  end
  
  def title
    @language.title
  end
  
  def selected?
    @current_page.language_code == code
  end
  
  def code
    @language.code
  end
  
  def url
    "/#{code}"
  end
end