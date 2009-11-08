require 'yaml'
require 'mash'

class Data
  def self.load(datafile)
    @@db = Mash.new(YAML::load(File.open(datafile)))
  end
  
  def self.db
    @@db
  end
  
  def self.page(path)
    db.pages.find { |p| p.path == path }
  end
  
  def self.resolve_page(path)
    page = self.page(path)
    if page.nil?
      path = path.split('/')[0...-1] * '/'
      page = self.page(path)
      page if page.content_type == 'blog'
    else
      page
    end
  end
  
  def self.page_children(path)
    db.pages.select { |p| p.path =~ %r{^#{path}\/} && p.path.split('/').size == (path.split('/').size + 1) }
  end
  
  def self.content_for_page(content_name, page_path)
    p = page(page_path)
    if p.contents && p.contents[content_name]
      p.contents[content_name]
    else
      db.contents[content_name]
    end
  end
  
  def self.article(path)
    db.articles.find { |a| a.path == path }
  end
  
  def self.person(code)
    db.people[code]
  end
end
