require 'rails_helper'

RSpec.describe 'GET /api/v1/backgrounds?location=X', type: :request do
  xit 'given a city, state, should return an image' do
    VCR.use_cassette('killeen_image') do
      location = 'Killeen, TX'
      get api_v1_background_path, params: { location: location }

      expect(response.status).to eq(200)
      image = JSON.parse(response.body, symbolize_names: true)
      expect(image[:data][:attributes][:image][:image_url]).to be_a String
      expect(image[:data][:attributes][:image][:location]).to eq(location)
      expect(image[:data][:attributes][:image]).to have_key(:credit)
    end
  end
end
