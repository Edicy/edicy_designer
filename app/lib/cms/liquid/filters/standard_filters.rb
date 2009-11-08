module CMS::Liquid::Filters::StandardFilters
  
  def format_date(input, format = :default)
    return input.to_s if format.to_s.empty?

    date = case input
    when String
      Date.parse(input)
    when Time
      input.to_date
    else
      input
    end
    
    if date.is_a?(Date)
      I18n.l(date, :format => format)
    else
      input
    end
  rescue => e 
    input
  end
  
  def format_time(input, format = :default)
    return input.to_s if format.to_s.empty?

    time = case input
    when String
      Time.parse(input)
    when Date
      input.to_time
    else
      input
    end
    
    if time.is_a?(Time)
      I18n.l(time, :format => format)
    else
      input
    end
  rescue => e 
    input
  end

end

Liquid::Template.register_filter(CMS::Liquid::Filters::StandardFilters)
