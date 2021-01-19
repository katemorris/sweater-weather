# frozen_string_literal: true

require 'rails_helper'

describe MunchiesFacade do
  describe 'class methods' do
    before :each do
      allow(Time).to receive(:now).and_return(Time.local(2021, 1, 19, 9, 10))
    end
    it '.trip_data()' do
      VCR.use_cassette('munchies_facade') do
        origin = 'Denver, CO'
        destination = 'New Bern, NC'
        food_type = 'burger'
        response = MunchiesFacade.trip_data(origin, destination, food_type)
        expect(response).to be_a Munchie
        expect(response.destination_city).to eq(destination)
        expect(response.travel_time).to eq('26:31:58')
        expect(response.forecast).to be_a Hash
        expect(response.restaurant).to be_a Restaurant
      end
    end
  end
end
