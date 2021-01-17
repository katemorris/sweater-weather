# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherService do
  describe 'class methods' do
    it '.forecast()' do
      VCR.use_cassette('sample_forecast') do
        coords = { lat: 31.1178, lng: -97.7311 }
        response = WeatherService.forecast(coords)

        expect(response).to be_a Hash

        expect(response).to be_a Hash
        expect(response).to have_key(:current)
        expect(response).to have_key(:hourly)
        expect(response).to have_key(:daily)
        expect(response).to_not have_key(:alerts)
      end
    end
  end
end
