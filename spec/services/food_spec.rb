# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodService do
  describe 'class methods' do
    it '.restaurant()' do
      VCR.use_cassette('sample_restaurant') do
        location = 'Jackson Hole, WY'
        time = 1618907370
        category = 'thai'
        response = FoodService.restaurant(location, time, category)

        expect(response).to be_a Hash
        expect(response).to have_key(:lat)
        expect(response).to have_key(:lng)
        expect(response).to_not have_key(:street)
        expect(response).to_not have_key(:latlng)
      end
    end
  end
end
