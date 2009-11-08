class ElementDrop < Liquid::Drop
  
  def initialize(elem)
  end
  
  def id
  end
  
  def new_record?
  end
  
  def title
  end
  
  def page
  end
  
  def before_method(method)
  end
  
  def method_missing(id, *args)
    if @elem.has_property?(id) and id != :title
      @elem.send(id)
    else
      super
    end
  end
  
  def respond_to?(id)
    if @elem.has_property?(id) and id != :title
      true
    else
      super
    end
  end
  
  def url
  end
end