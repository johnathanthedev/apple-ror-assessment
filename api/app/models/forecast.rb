class Forecast < ApplicationRecord
  belongs_to :location

  validates :current, :daily, presence: true

  def self.for_coordinates(lat, lon)
    cache_key = "forecast_#{lat}_#{lon}"

    forecast_data = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      fetch_forecast_by_coordinates(lat, lon)
    end

    cache_hit = Rails.cache.exist?(cache_key)

    if cache_hit
      { forecast: forecast_data, cached: true }
    else
      location = Location.find_or_create_by(lat: lat, lon: lon)

      existing_forecast = Forecast.find_by(location: location)
      if existing_forecast
        existing_forecast.update(current: forecast_data[:current], daily: forecast_data[:daily])
        { forecast: existing_forecast, cached: false }
      else
        new_forecast = Forecast.create!(
          location: location,
          current: forecast_data[:current],
          daily: forecast_data[:daily]
        )
        { forecast: new_forecast, cached: false }
      end
    end
  end

  private

  def self.fetch_forecast_by_coordinates(lat, lon)
    WeatherService.get_forecast_by_coordinates(lat, lon)
  end
end
