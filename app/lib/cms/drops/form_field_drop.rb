class FormFieldDrop < Liquid::Drop
  
  # include ActionView::Helpers::TagHelper
  # include ActionView::Helpers::FormTagHelper
  # include ActionView::Helpers::FormOptionsHelper
  
  attr_accessor :errors, :value
  
  def initialize(form_field)
    @field = form_field
    @selector_item_id = 0
  end
  
  def title
    @field.title.to_s
  end
  
  def required?
    @field.required?
  end
  
  def label_tag
    labelfor = " for=\"#{field_id}\"" unless [:checkbox, :radio].include?(@field.type)
    reqmarker = if required? then '*' else '' end
    "<label#{labelfor}>#{title}#{reqmarker}</label>"
  end
  
  def paragraph?
    @field.paragraph?
  end
  
  def paragraph
    @field.paragraph
  end
  
  def field_tag
    tag_class = "form_field_#{@field.type}"
    case @field.field_size
    when 'small'
      tag_class << ' form_field_size_small'
    when 'medium'
      tag_class << ' form_field_size_medium'
    when 'large'
      tag_class << ' form_field_size_large'
    end
    
    case @field.type
    when :textfield
      text_field_tag name, @value, :id => field_id, :class => tag_class
    when :textarea
      rows = unless @field.rows.nil? then @field.rows.to_i else '4' end
      cols = unless @field.cols.nil? then @field.cols.to_i else '20' end
      text_area_tag name, @value, :id => field_id, :rows => rows, :cols => cols, :class => tag_class
    when :file
      file_field_tag name, :id => field_id, :class => tag_class
    when :select
      options = options_for_select(@field.options.collect{ |option| [option, option] }, @value)
      select_tag name, options, :multiple => @field.multiple?, :id => field_id, :class => tag_class
    when :checkbox
      @field.options.inject('') do |output, option|
        checked = @value.is_a?(Array) && @value.include?(option)
        output << '<div>'
        output << check_box_tag(name, option, checked, :id => selector_item_id, :class => tag_class)
        output << option
        output << '</div>'
        output
      end if @field.options
    when :radio
      @field.options.inject('') do |output, option|
        checked = @value.is_a?(Array) && @value.include?(option)
        output << '<div>'
        output << radio_button_tag(name, option, checked, :id => selector_item_id, :class => tag_class)
        output << option
        output << '</div>'
        output
      end if @field.options
    end
  end
  
  # Returns field name attribute
  def name
    case @field.type
    when (:checkbox or :radio)
      "ticket[data][#{@field.key}][]"
    else
      "ticket[data][#{@field.key}]"
    end
  end
  
  def errors?
    !@errors.empty? unless @errors.nil?
  end
  
  def errors
    @errors
  end
  
  def field_id
    "field_#{@field.key}"
  end
  
  def selector_item_id
    "#{field_id}_#{@selector_item_id += 1}"
  end
end