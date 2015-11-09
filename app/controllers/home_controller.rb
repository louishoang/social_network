class HomeController < ApplicationController
  before_action :authenticate_user!
  caches_page :weather
  
  def index
    
  end

  def weather
    require 'net/http'
    link = "http://api.openweathermap.org/data/2.5/weather?lat=" + params[:latitude] + "&lon=" + params[:longitude] + "&APPID=" + ENV["WEATHER_APP_ID"]
    result = Net::HTTP.get(URI.parse(link)) rescue nil
    if result
      @weather_data = JSON.parse(result) rescue nil
    end

    render :partial => 'weather'
  end
end
