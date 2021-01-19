# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Forecast do
  before :each do
    file = File.read('spec/fixtures/sample_forecast.json')
    @data = JSON.parse(file, symbolize_names: true)

    @forecast = Forecast.new(@data)
  end

  it 'that it exists' do
    expect(@forecast.current_weather).to be_a CurrentWeather
    expect(@forecast.hourly_weather).to be_an Array
    expect(@forecast.hourly_weather.first).to be_an HourlyWeather
    expect(@forecast.daily_weather).to be_an Array
    expect(@forecast.daily_weather.first).to be_a DailyWeather
  end

  describe 'instance methods' do
    it '#datetime_conversion()' do
      data = 1_610_841_600
      expect(@forecast.datetime_conversion(data)).to eq('2021/01/16 17:00:00')
    end
  end
end
