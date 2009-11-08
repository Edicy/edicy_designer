# Blog is a special type of PageDrop, having access to articles in this blog.
class BlogDrop < Liquid::Drop
  
  def initialize(page)
    @page = page
  end
  
  # Returns absolute URL to RSS feed of this blog
  def rss_url
    [@page.path, 'rss'] * '.'
  end
  
  # Generates LINK tag for RSS-feed. Use inside HEAD tag
  #
  #   {{ blog.rss_link }}
  #   #=> <link rel="alternate" type="application/rss+xml" title="RSS" href="url/to/blog.rss">
  #
  def rss_link
  end
  
  # Returns reference to page
  def page
    PageDrop.new(@page, page)
  end
  
  # Returns list of all articles in this blog. Each list item is an ArticleDrop object.
  def articles
    articles = Data.db.articles.inject(Array.new) do |a, article|
      a << ArticleDrop.new(article).to_liquid if article.page == @page.path
      a
    end
    # Order articles in descended order
    articles.sort { |a1, a2| a2.created_at <=> a1.created_at }
  end
  
  # Returns 10 latest articles from this blog.
  def latest_articles(limit = 10)
    articles[0..limit]
  end
  
  # Responds to dynamically named methods. Allows user to query the latest_n_articles on this blog.
  def before_method(method)
    if method.to_s.match(/^latest_(\d+)_articles$/)
      latest_articles($1.to_i)
    end
  end
end