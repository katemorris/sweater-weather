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

    it '.forecast()' do
      VCR.use_cassette('rt_facade_forecast') do
        destination = 'New Bern, NC'
        response = RoadTripFacade.forecast(destination)
        expect(response).to be_a Hash
        expect(response).to have_key(:hourly)
        expect(response[:hourly]).to be_an Array
      end
    end

    it '.travel_in_seconds()' do
      time1 = '26:31:58'
      response1 = RoadTripFacade.travel_in_seconds(time1)
      expect(response1).to be_a Numeric
      expect(response1).to eq(95518)

      time2 = '07:31:58'
      response2 = RoadTripFacade.travel_in_seconds(time2)
      expect(response2).to be_a Numeric
      expect(response2).to eq(27118)
    end

    it '.hourly_weather()' do
      VCR.use_cassette('rt_facade_hourly_weather') do
        destination = 'New Bern, NC'
        time = '07:31:58'
        response = RoadTripFacade.hourly_weather(destination, time)
        expect(response).to be_a Hash
        expect(response[:dt]).to be_an Integer
        expect(response[:weather]).to be_an Array
        expect(response[:weather].first).to have_key(:description)
      end
    end
  end
end
