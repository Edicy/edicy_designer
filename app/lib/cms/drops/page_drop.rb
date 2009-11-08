class PageDrop < Liquid::Drop
  
  def initialize(page)
    @page = page
  end
  
  def title
    @page.title
  end
  
  def keywords
    @page.keywords
  end
  
  def description
    @page.description
  end
  
  def path
    @page.path
  end
  
  def path_with_lang
    @page.path
  end
  
  def created_at
    Time.now
  end
  
  def updated_at
    Time.now
  end
  
  def hidden?
    @page.hidden
  end
  
  def page_id
    1
  end
  
  def node_id
    1
  end
  
  def language_id
    1
  end
  
  def language_code
    @page.language_code
  end
  
  def url
    '/' + @page.path
  end
  
  def blog?
    @page.content_type == 'blog'
  end
  
  def new_record?
    false
  end
end