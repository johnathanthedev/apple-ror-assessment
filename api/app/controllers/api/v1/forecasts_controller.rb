class Api::V1::ForecastsController < ApplicationController
  def get_forecast
    postal_code = forecast_params[:postal_code]

    if postal_code
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
    
    lat = data[:coordinates][:lat]
    lon = data[:coordinates][:lon]

    forecast = Forecast.for_coordinates(lat, lon)

    render json: forecast, status: :ok
  end

  private

  def forecast_params
    params.require(:forecast).permit(:city, :state, :postal_code)
  end
end