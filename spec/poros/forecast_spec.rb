# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Forecast do
  before :each do
    file = File.read('spec/fixtures/sample_forecast.json')
    @data = JSON.parse(file, symbolize_names: true)

    @forecast = Forecast.new(@data)
  end

  it "that it exists" do
    expect(@forecast.current_weather).to be_a CurrentWeather
    expect(@forecast.hourly_weather).to be_an Array
    expect(@forecast.hourly_weather.first).to be_an HourlyWeather
    expect(@forecast.daily_weather).to be_an Array
    expect(@forecast.daily_weather.first).to be_a DailyWeather
  end

  describe 'instance methods' do
    it '#datetime_conversion()' do
      data = 1610841600
      expect(@forecast.datetime_conversion(data)).to eq("Sat, 16 Jan 2021 17:00:00.000000000 -0700")
    end
  end
end
