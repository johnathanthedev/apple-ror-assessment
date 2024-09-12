require 'rails_helper'
require 'webmock/rspec'

RSpec.describe GeocodingService, type: :service do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  describe '.get_coordinates_by_city' do
    let(:city) { 'Chicago' }
    let(:state) { 'Illinois' }
    let(:address) { { city: city, state: state } }
    let(:response_body) do
      {
        "lat" => 41.8781,
        "lon" => -87.6298
      }.to_json
    end

    before do
      stub_request(:get, "http://api.openweathermap.org/geo/1.0/direct?q=#{city},#{state}&limit=1&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
        .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })
    end

    it 'returns the correct coordinates for a city' do
      result = GeocodingService.get_coordinates_by_city(address)
      expect(result).to eq({ "coordinates": { "lat": 41.8781, "lon": -87.6298 } })
    end
  end

  describe '.get_coordinates_by_postal_code' do
    let(:postal_code) { '60601' }
    let(:response_body) do
      {
        "lat" => 41.8837,
        "lon" => -87.6233
      }.to_json
    end

    before do
      stub_request(:get, "http://api.openweathermap.org/geo/1.0/zip?zip=#{postal_code}&limit=1&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
        .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })
    end

    it 'returns the correct coordinates for a postal code' do
      result = GeocodingService.get_coordinates_by_postal_code(postal_code)
      expect(result).to eq({ "coordinates": { "lat": 41.8837, "lon": -87.6233 } })
    end
  end

  describe '.get_coordinates_from_response_data' do
    context 'when the response data is an array' do
      let(:response_data) do
        [
          {
            "lat" => 41.8781,
            "lon" => -87.6298
          }
        ]
      end

      it 'extracts coordinates from array response data' do
        result = GeocodingService.send(:get_coordinates_from_response_data, response_data)
        expect(result).to eq({ "lat": 41.8781, "lon": -87.6298 })
      end
    end

    context 'when the response data is not an array' do
      let(:response_data) do
        {
          "lat" => 41.8781,
          "lon" => -87.6298
        }
      end

      it 'extracts coordinates from non-array response data' do
        result = GeocodingService.send(:get_coordinates_from_response_data, response_data)
        expect(result).to eq({ "lat": 41.8781, "lon": -87.6298 })
      end
    end

    context 'when the response contains errors' do
      let(:response_data_with_error) { { "cod" => "404" } }

      it 'returns nil for error responses' do
        result = GeocodingService.send(:get_coordinates_from_response_data, response_data_with_error)
        expect(result).to be_nil
      end
    end
  end
end
