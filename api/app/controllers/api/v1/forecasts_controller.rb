class Api::V1::ForecastsController < ApplicationController
  # When hitting endpoint the provided payload will need to include city, state and postal code.
  # postal code is optional and will only be accessed if field is not empty string.
  # postal code lookup is prioritized.
  # If want to lookup by city/state then postal code needs to be empty string: ""
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