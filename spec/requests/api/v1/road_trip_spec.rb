# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/road_trip', type: :request do
  it 'should return data for a road trip if authorized' do
    User.create!(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password',
      api_key: '890fhdusrjufs83jkf'
    )
    VCR.use_cassette('sample_road_trip') do
      data = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "890fhdusrjufs83jkf"
      }
      post api_v1_road_trip_path, params: data, as: :json

      expect(response.status).to eq(200)
      trip = JSON.parse(response.body, symbolize_names: true)
      road_trip_checker(trip)
    end
  end
end
