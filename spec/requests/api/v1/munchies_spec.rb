# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/munchies', type: :request do
  it 'should return weather, travel time, and food options for a trip' do
    VCR.use_cassette('sample_munchies') do
      data = {
        "start": 'Denver,CO',
        "end": 'Jackson Hole, WY',
        "food": "thai"
      }
      get api_v1_munchies_path, params: data

      expect(response.status).to eq(200)
      munchies = JSON.parse(response.body, symbolize_names: true)
      require "pry"; binding.pry
    end
  end

  xit 'should return data even on long trips' do
    VCR.use_cassette('long_road_trip') do
      data = {
        "origin": 'New York, NY',
        "destination": 'Los Angeles, CA',
        "api_key": @user.api_key
      }
      post api_v1_road_trip_path, params: data, as: :json

      expect(response.status).to eq(200)
      trip = JSON.parse(response.body, symbolize_names: true)
      road_trip_checker(trip)
    end
  end

  xit 'should return data even on long trips' do
    VCR.use_cassette('impossible_road_trip') do
      data = {
        "origin": 'New York, NY',
        "destination": 'London, UK',
        "api_key": @user.api_key
      }
      post api_v1_road_trip_path, params: data, as: :json

      expect(response.status).to eq(200)
      trip = JSON.parse(response.body, symbolize_names: true)
      expect(trip[:data][:attributes][:travel_time]).to eq('Impossible Route')
      expect(trip[:data][:attributes][:weather_at_eta]).to eq('')
    end
  end

  xit 'should return unauthorized if api_key is not correct' do
    data = {
      "origin": 'Denver,CO',
      "destination": 'Pueblo,CO',
      "api_key": 'NONSENSE'
    }
    post api_v1_road_trip_path, params: data, as: :json

    expect(response.status).to eq(401)
    message = JSON.parse(response.body, symbolize_names: true)
    expect(message[:message]).to eq('unauthorized')
  end
end
