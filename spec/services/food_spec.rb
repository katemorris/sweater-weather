# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodService do
  describe 'class methods' do
    it '.restaurants()' do
      VCR.use_cassette('sample_restaurant') do
        location = 'Jackson Hole, WY'
        time = 1611178170
        category = 'thai'
        response = FoodService.restaurants(location, time, category)

        expect(response).to be_a Array
        expect(response.first).to have_key(:name)
        expect(response.first).to have_key(:is_closed)
        expect(response.first).to have_key(:categories)
        expect(response.first).to have_key(:location)
        expect(response.first[:location]).to have_key(:display_address)
      end
    end
  end
end
