require 'net/http'
require 'json'

class WeatherService
  API_KEY = ENV['OPEN_WEATHER_API_KEY']
  WEATHER_API_URL="https://api.openweathermap.org/data/3.0/onecall"
  
  def self.get_forecast_by_coordinates(lat, lon)
    url = "#{WEATHER_API_URL}?lat=#{lat}&lon=#{lon}&units=imperial&appid=#{API_KEY}"
    response = Net::HTTP.get(URI(url))
    data = JSON.parse(response)

    {
      current: {
        temp: data["current"]["temp"],
        weather: {
          type: data["current"]["weather"].first["main"],
          description: data["current"]["weather"].first["description"],
        }
      },
    daily: data["daily"].map do |daily|
      {
        timestamp: daily["dt"],
        high: daily["temp"]["max"],
        low: daily["temp"]["min"],
        weather: {
          type: daily["weather"].first["main"],
          description: daily["weather"].first["description"]
        }
      }
    end
    }
  end
end