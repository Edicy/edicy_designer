class SiteDrop < Liquid::Drop
  
  def initialize
  end
  
  def id
    1
  end
  
  def menuitems
    Data.db.pages.inject(Array.new) do |a, p|
      a << MenuItemDrop.new(PageDrop.new(p).to_liquid, page) if p.path.split('/').size < 2 && p.path != ''
      a
    end
  end
  
  def menuitems_with_hidden
    menuitems
  end
  
  def all_menuitems
    menuitems
  end
  
  def languages
    Data.db.languages.inject(Array.new) do |a, l|
      a << LanguageDrop.new(l, page).to_liquid
      a
    end
  end
  
  def has_many_languages?
    languages.size > 1
  end

  def root_item
    MenuItemDrop.new(PageDrop.new(Data.page('')), page)
  end
  
  def rss_path
    '/index.rss'
  end
  
  def author
    Data.db.site.author
  end
  
  def keywords
    Data.db.site.keywords
  end
  
  def copyright
    Data.db.site.copyright
  end
  
  def name
    Data.db.site.name
  end
  
  def header
    Data.db.site.name
  end
  
  def analytics
    Data.db.site.analytics
  end
  
  def search
    {'enabled' => Data.db.site.search_enabled}
  end
  
  def logo
    ""
  end
  
  def blogs
    Data.db.pages.inject(Array.new) do |a, page|
      a << PageDrop.new(page).to_liquid if page.content_type == 'blog'
      a
    end
  end
  
  def latest_articles(limit = 10)
    Data.db.articles.inject(Array.new) do |a, article|
      a << ArticleDrop.new(article).to_liquid
      a
    end
  end
  
  def static_asset_host
    'http://static.edicy.com'
  end
  
  # Responds to dynamically named methods. Allows user to query the latest_n_articles on site.
  def before_method(method)
    if method.to_s.match(/^latest_(\d+)_articles$/)
      latest_articles($1.to_i)
    end
  end
end