require 'rails_helper'
require 'webmock/rspec'

RSpec.describe WeatherService, type: :service do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  describe '.get_forecast_by_coordinates' do
    let(:lat) { 41.8781 }
    let(:lon) { -87.6298 }
    let(:response_body) do
      {
        "current" => {
          "temp" => 72.0,
          "weather" => [
            { "main" => "Clear", "description" => "clear sky" }
          ]
        },
        "daily" => [
          {
            "dt" => 1630425600,
            "temp" => { "max" => 80.0, "min" => 60.0 },
            "weather" => [
              { "main" => "Clouds", "description" => "few clouds" }
            ]
          },
          {
            "dt" => 1630512000,
            "temp" => { "max" => 78.0, "min" => 58.0 },
            "weather" => [
              { "main" => "Rain", "description" => "light rain" }
            ]
          }
        ]
      }.to_json
    end

    before do
      stub_request(:get, "https://api.openweathermap.org/data/3.0/onecall?lat=#{lat}&lon=#{lon}&units=imperial&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
        .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })
    end

    it 'returns the correct current weather and daily forecast' do
      result = WeatherService.get_forecast_by_coordinates(lat, lon)
      
      expected_result = {
        current: {
          temp: 72.0,
          weather: {
            type: "Clear",
            description: "clear sky"
          }
        },
        daily: [
          {
            timestamp: 1630425600,
            high: 80.0,
            low: 60.0,
            weather: {
              type: "Clouds",
              description: "few clouds"
            }
          },
          {
            timestamp: 1630512000,
            high: 78.0,
            low: 58.0,
            weather: {
              type: "Rain",
              description: "light rain"
            }
          }
        ]
      }

      expect(result).to eq(expected_result)
    end
  end
end
