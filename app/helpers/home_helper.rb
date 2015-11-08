module HomeHelper
  def convert_temp(string)
    %Q(#{(string.to_f * 2 * 1/10 -7.4 +32).round(1)} &deg;F).html_safe
  end

  def location(weather_data)
    %Q(#{weather_data["name"]}, #{weather_data["sys"]["country"]})
  end
end
