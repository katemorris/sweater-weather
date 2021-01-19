# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherService do
  describe 'class methods' do
    it '.forecast()' do
      VCR.use_cassette('sample_forecast') do
        coords = { lat: 31.1178, lng: -97.7311 }
        exclude1 = 'minutely,alerts'
        exclude2 = 'daily,current,minutely,alerts'
        response = WeatherService.forecast(coords, exclude1)

        expect(response).to be_a Hash

        expect(response).to have_key(:current)
        expect(response[:current]).to be_a Hash
        expect(response[:current]).to have_key(:dt)
        expect(response[:current][:dt]).to be_an Integer
        expect(response[:current]).to have_key(:sunrise)
        expect(response[:current][:dt]).to be_an Integer
        expect(response[:current]).to have_key(:temp)
        expect(response[:current][:temp]).to be_an Float
        expect(response[:current]).to have_key(:humidity)
        expect(response[:current][:dt]).to be_a Numeric
        expect(response[:current]).to have_key(:weather)

        expect(response).to have_key(:hourly)
        expect(response[:hourly]).to be_an Array
        expect(response[:hourly].first).to have_key(:dt)
        expect(response[:hourly].first[:dt]).to be_an Integer
        expect(response[:hourly].first).to have_key(:temp)
        expect(response[:hourly].first[:temp]).to be_an Numeric
        expect(response[:hourly].first).to have_key(:weather)
        expect(response[:hourly].first[:weather]).to be_an Array

        expect(response).to have_key(:daily)
        expect(response[:daily]).to be_a Array
        expect(response[:daily].first).to have_key(:dt)
        expect(response[:daily].first[:dt]).to be_an Integer
        expect(response[:daily].first).to have_key(:temp)
        expect(response[:daily].first[:temp]).to be_a Hash

        expect(response).to_not have_key(:alerts)

        response2 = WeatherService.forecast(coords, exclude2)

        expect(response2).to be_a Hash
        expect(response2).to have_key(:hourly)
        expect(response[:hourly]).to be_an Array
        expect(response2).to_not have_key(:current)
        expect(response2).to_not have_key(:daily)
        expect(response2).to_not have_key(:alerts)
      end
    end
  end
end
