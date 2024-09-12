class Forecast < ApplicationRecord
  validates :lat, :lon, presence: true

  def self.for_coordinates(lat, lon)
    fetch_forecast_by_coordinates(lat, lon)
  end

  def self.fetch_forecast_by_coordinates(lat, lon)
    WeatherService.get_forecast_by_coordinates(lat, lon)
  end
end
