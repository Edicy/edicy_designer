# Represents single menu item object in site structure to Liquid.
class MenuItemDrop < Liquid::Drop
  
  def initialize(page, current_page, node = nil)
    @page = page
    @current_page = current_page
  end
  
  def title
    @page.title
  end
  
  def page_id
    @page.id
  end
  
  def path
    @page.path
  end

  def url
    @page.url
  end
  
  # Returns content type of the page associated with this item
  def content_type
    @page.content_type
  end
  
  # Returns true if page associated with this item is a blog
  def blog?
    @page.blog?
  end
  
  # Returns true if page or one of its children (or one of their childrens etc.) is currently shown.
  def selected?
    @selected ||= (@current_page.path + '/').index(@page.path + '/') == 0
  end
  
  # Returns true if current page is shown.
  def current?
    @current ||= @page.path == @current_page.path
  end
  
  # Returns list of MenuItemDrop objects which represents children of page this MenuItemDrop represents.
  def children
    Data.page_children(@page.path).inject(Array.new) do |a, p|
      a << MenuItemDrop.new(PageDrop.new(p).to_liquid, @current_page)
      a
    end
  end

  # Returns list of MenuItemDrop objects which represents also hidden children of page this MenuItemDrop represents.
  def children_with_hidden
    children
  end

  # Returns list of MenuItemDrop objects which are representing all children (whether translated or untranslated) of
  # current MenuItemDrop
  def all_children
    children
  end
  
  # Returns true if menu item has child objects (only translated objects)
  def children?
    ! children.empty?
  end
  
  # Returns true if menu item has child objects (both translated or untranslated)
  def all_children?
    ! all_children.empty?
  end
  
  # Returns true if this menu item is currently selected AND also has children
  def selected_with_children?
    children? and selected?
  end
  
  # Check if this menu item is already translated
  def translated?
    ! @page.new_record?
  end
  
  # Check if page is hidden
  def hidden?
    @page.hidden?
  end
  
  def position
    1
  end
end