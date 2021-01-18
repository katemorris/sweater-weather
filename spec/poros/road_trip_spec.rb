# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoadTrip do
  before :each do
    @origin = 'Denver, CO'
    @destination = 'Killeen, TX'
    @time = '16:34:00'
    @weather = HourlyWeather.new({
                                   dt: 1_610_946_000,
                                   temp: 35.13,
                                   feels_like: 27.45,
                                   pressure: 1013,
                                   humidity: 69,
                                   dew_point: 26.69,
                                   uvi: 0,
                                   clouds: 4,
                                   visibility: 10_000,
                                   wind_speed: 5.88,
                                   wind_deg: 287,
                                   weather: [{ id: 800, main: 'Clear', description: 'clear sky',
                                               icon: '01n' }],
                                   pop: 0
                                 })
    @rt = RoadTrip.new(@origin, @destination, @time, @weather)
  end

  it 'that it exists' do
    expect(@rt.start_city).to eq(@origin)
    expect(@rt.end_city).to eq(@destination)
    expect(@rt.travel_time).to eq(@time)
    expect(@rt.weather_at_eta[:temperature]).to eq(@weather.temperature)
    expect(@rt.weather_at_eta[:conditions]).to eq(@weather.conditions)
    expect(@rt.id).to eq('null')
  end

  describe 'instance methods' do
    it '#weather_grabber()' do
      expected = {
        temperature: 35.13,
        conditions: 'clear sky'
      }
      expect(@rt.weather_grabber(@weather)).to eq(expected)
    end
  end
end
