# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapService do
  describe 'class methods' do
    it '.coordinates()' do
      VCR.use_cassette('sample_coordinates') do
        location = "Johnson City, TN"
        response = MapService.coordinates(location)

        expect(response).to be_a Hash

        expect(response).to be_a Hash
        expect(response).to have_key(:lat)
        expect(response).to have_key(:lng)
        expect(response).to_not have_key(:street)
        expect(response).to_not have_key(:latlng)
      end
    end
  end
end