class TextPartialDrop < Liquid::Drop
  
  def initialize(text_partial)
    @text_partial = text_partial
  end
  
  def id
    @text_partial.id
  end
  
  def body
    @text_partial.body
  end
end