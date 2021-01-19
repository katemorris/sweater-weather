# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/road_trip', type: :request do
  before :each do
    @user = create(:user,
                   email: 'whatever@example.com',
                   password: 'password',
                   password_confirmation: 'password')
  end

  it 'should return data for a road trip if authorized' do
    VCR.use_cassette('sample_road_trip') do
      data = {
        "origin": 'Denver,CO',
        "destination": 'Pueblo,CO',
        "api_key": @user.api_key
      }
      post api_v1_road_trip_path, params: data, as: :json

      expect(response.status).to eq(200)
      trip = JSON.parse(response.body, symbolize_names: true)
      road_trip_checker(trip)
    end
  end

  it 'should return data even on long trips' do
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

  it 'should return data even on long trips' do
    VCR.use_cassette('impossible_road_trip') do
      data = {
        "origin": 'New York, NY',
        "destination": 'London, UK',
        "api_key": @user.api_key
      }
      post api_v1_road_trip_path, params: data, as: :json

      expect(response.status).to eq(200)
      trip = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(trip[:attributes][:travel_time]).to eq('Impossible Route')
      expect(trip[:attributes][:weather_at_eta][:conditions]).to eq('none')
      expect(trip[:attributes][:weather_at_eta][:temperature]).to eq('none')
    end
  end

  it 'should return unauthorized if api_key is not correct' do
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
