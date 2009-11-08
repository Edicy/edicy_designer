class FormDrop < Liquid::Drop
  
  # include ActionView::Helpers::TagHelper
  # include ActionView::Helpers::FormTagHelper
  # include ActionView::Helpers::FormOptionsHelper
  
  attr_accessor :error, :notice, :ticket, :submit_path, :authenticity_token, :partial_id
  
  def initialize(form, ticket = nil)
    @form = form
    @ticket = ticket
  end
  
  def fields?
    @form.has_fields?
  end
  
  def fields
    @fields ||= @form.fields.inject(Array.new) do |a, f|
      field = FormFieldDrop.new(f)
      if @ticket && @ticket.errors.on(f.key)
        if @ticket.errors.on(f.key).is_a?(Array)
          field.errors = @ticket.errors.on(f.key).inject(Array.new) do |errors, e|
            errors << I18n.t("app.site.forms.#{e}")
            errors
          end
        else
          field.errors = [I18n.t('app.site.forms.' + @ticket.errors.on(f.key))]
        end
      end
      field.value = @ticket.value(f.key) if @ticket.respond_to?(:value)
      a << field
      a
    end
  end
  
  def form_element_id
    "form_#{@form.id}"
  end
  
  def submit_button
    label = if @form.submit_label.blank? then I18n.t('app.site.forms.submit_form') else @form.submit_label end
    submit_tag(label)
  end
  
  def start_tag
    enctype = if @form.multipart? then ' enctype="multipart/form-data"' else '' end
    [
      "<form action=\"#{@submit_path}\" method=\"post\" id=\"#{form_element_id}\"#{enctype}>",
      "<div style=\"margin:0;padding:0;\">",
      hidden_field_tag('ticket[form_id]', @form.id),
      hidden_field_tag('form[partial_id]', @partial_id),
      "</div>"
    ] * "\n"
  end
  
  def end_tag
    '</form>'
  end
end