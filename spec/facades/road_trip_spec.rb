# frozen_string_literal: true

require 'rails_helper'

describe RoadTripFacade do
  describe 'class methods' do
    it '.trip_data()' do
      VCR.use_cassette('road_trip_facade') do
        origin = 'Denver, CO'
        destination = 'New Bern, NC'
        response = RoadTripFacade.trip_data(origin, destination)
        expect(response).to be_a RoadTrip
        expect(response.start_city).to eq(origin)
        expect(response.end_city).to eq(destination)
        expect(response.travel_time).to eq('26:31:58')
      end
    end
  end
end
