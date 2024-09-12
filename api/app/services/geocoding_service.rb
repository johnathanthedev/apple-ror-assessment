require 'net/http'
require 'json'

class GeocodingService
  CITY_GEOCODING_API_URL = 'http://api.openweathermap.org/geo/1.0/direct'
  POSTAL_GEOCODING_API_URL = 'http://api.openweathermap.org/geo/1.0/zip'
  API_KEY = ENV['OPEN_WEATHER_API_KEY']

  def self.get_coordinates_by_city(address)
    city = address[:city]
    state = address[:state]
    url = "#{CITY_GEOCODING_API_URL}?q=#{city},#{state}&limit=1&appid=#{API_KEY}"

    response = Net::HTTP.get(URI(url))
    data = JSON.parse(response)

    coordinates = get_coordinates_from_response_data(data)

    {
      "coordinates": coordinates
    }
  end

  def self.get_coordinates_by_postal_code(code)
    url = "#{POSTAL_GEOCODING_API_URL}?zip=#{code}&limit=1&appid=#{API_KEY}"

    response = Net::HTTP.get(URI(url))
    data = JSON.parse(response)

    coordinates = get_coordinates_from_response_data(data)

    {
      "coordinates": coordinates
    }
  end

  private

  def self.get_coordinates_from_response_data(data)
    # The return payload is not consistent between retrieving geo location for
    # city or postal code. Both use different endpoints.
    
    # The following is my attempt at accomodating for the inconsistency.
    response_code = (data.is_a?(Array) && data.size) ? nil : data['cod']

    # Sometimes the response codes are either integers or string based values
    if response_code && response_code == 401 || response_code == 400 || response_code == "404" || response_code == "400"
      nil
    else      
      lat = data.is_a?(Array) ? data.first["lat"] : data["lat"]
      lon = data.is_a?(Array) ? data.first["lon"] : data["lon"]

      coordinates = {
        "lat": lat,
        "lon": lon
      }
    end
  end
end
