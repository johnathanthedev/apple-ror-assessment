class Api::V1::ForecastsController < ApplicationController
  def get_forecast
    postal_code = forecast_params[:postal_code]

    # Checks if postal_code is not empty otherwise defaults to
    # city based coords lookup
    if !postal_code.empty?
      data = GeocodingService.get_coordinates_by_postal_code(postal_code)
    else
      city = forecast_params[:city]
      state = forecast_params[:state]
      address = {
        "city": city,
        "state": state
      }

      data = GeocodingService.get_coordinates_by_city(address)
    end

    forecast = {
      forecast: nil
    }

    if data[:coordinates]
      lat = data[:coordinates][:lat]
      lon = data[:coordinates][:lon]

      forecast = Forecast.for_coordinates(lat, lon)
    end

    render json: forecast, status: :ok
  end

  private

  def forecast_params
    params.require(:forecast).permit(:city, :state, :postal_code)
  end
end