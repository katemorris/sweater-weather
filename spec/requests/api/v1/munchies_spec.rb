# frozen_string_literal: true

require 'rails_helper'
require 'date'

RSpec.describe 'GET /api/v1/munchies', type: :request do
  before :each do
    allow(Time).to receive(:now).and_return(Time.local(2021, 1, 19, 9, 10))
  end
  it 'should return weather, travel time, and food options for a trip' do

    VCR.use_cassette('sample_munchies') do
      data = {
        "start": 'Denver,CO',
        "end": 'Jackson Hole, WY',
        "food": "thai"
      }
      get api_v1_munchies_path, params: data

      expect(response.status).to eq(200)
      munchies = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(munchies).to be_a Hash
      expect(munchies[:id]).to eq('null')
      expect(munchies[:type]).to eq('munchie')
      expect(munchies).to have_key(:attributes)
      expect(munchies[:attributes]).to be_a Hash
      expect(munchies[:attributes]).to have_key(:destination_city)
      expect(munchies[:attributes]).to have_key(:travel_time)
      expect(munchies[:attributes]).to have_key(:forecast)
      expect(munchies[:attributes][:forecast]).to have_key(:summary)
      expect(munchies[:attributes][:forecast]).to have_key(:temperature)
      expect(munchies[:attributes]).to have_key(:restaurant)
      expect(munchies[:attributes][:restaurant]).to have_key(:name)
      expect(munchies[:attributes][:restaurant]).to have_key(:address)
    end
  end

  it 'should return data even on long trips' do
    VCR.use_cassette('munchies_long_road_trip') do
      data = {
        "start": 'New York, NY',
        "end": 'Los Angeles, CA',
        "food": "thai"
      }
      get api_v1_munchies_path, params: data

      expect(response.status).to eq(200)
      munchies = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(munchies).to be_a Hash
      expect(munchies[:id]).to eq('null')
      expect(munchies[:type]).to eq('munchie')
      expect(munchies).to have_key(:attributes)
      expect(munchies[:attributes]).to be_a Hash
      expect(munchies[:attributes]).to have_key(:destination_city)
      expect(munchies[:attributes]).to have_key(:travel_time)
      expect(munchies[:attributes]).to have_key(:forecast)
      expect(munchies[:attributes][:forecast]).to have_key(:summary)
      expect(munchies[:attributes][:forecast]).to have_key(:temperature)
      expect(munchies[:attributes]).to have_key(:restaurant)
      expect(munchies[:attributes][:restaurant]).to have_key(:name)
      expect(munchies[:attributes][:restaurant]).to have_key(:address)
    end
  end

  it 'should not return data on impossible trips' do
    VCR.use_cassette('munchies_impossible_road_trip') do
      data = {
        "start": 'New York, NY',
        "end": 'London, UK',
        "food": "thai"
      }
      get api_v1_munchies_path, params: data

      expect(response.status).to eq(200)
      munchies = JSON.parse(response.body, symbolize_names: true)
      expect(munchies[:data][:attributes][:travel_time]).to eq('Impossible Route')
      expect(munchies[:data][:attributes][:forecast]).to eq('')
    end
  end
end
