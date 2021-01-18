# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/forecast?location=X', type: :request do
  it 'given a city, state, should return forecast data' do
    VCR.use_cassette('killeen_forecast') do
      location = 'Killeen, TX'
      get api_v1_forecast_path, params: { location: location }

      expect(response.status).to eq(200)
      forecast = JSON.parse(response.body, symbolize_names: true)
      forecast_get_response(forecast)
    end
  end

  it 'given an incomplete location, it will return a forecast by guessing' do
    VCR.use_cassette('arlington_incomplete_forecast') do
      location = 'Arlington'
      get api_v1_forecast_path, params: { location: location }

      expect(response.status).to eq(200)
      forecast = JSON.parse(response.body, symbolize_names: true)
      forecast_get_response(forecast)
    end
  end

  it 'given no location, no results are returned' do
    location = ''
    get api_v1_forecast_path, params: { location: location }

    expect(response.status).to eq(404)
    message = JSON.parse(response.body, symbolize_names: true)
    expect(message[:message]).to eq('Please fill in a location.')
  end
end
