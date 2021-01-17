# frozen_string_literal: true

require 'rails_helper'

describe ForecastFacade do
  describe 'class methods' do
    it '.by_location()' do
      VCR.use_cassette('forecast_facade') do
        location = 'New Bern, NC'
        response = ForecastFacade.by_location(location)
        expect(response).to be_a Forecast
      end
    end
  end
end
