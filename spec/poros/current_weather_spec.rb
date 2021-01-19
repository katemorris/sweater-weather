# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'that it exists' do
    data = {
      dt: 1_610_845_666,
      sunrise: 1_610_803_769,
      sunset: 1_610_841_102,
      temp: 49.55,
      feels_like: 40.53,
      pressure: 1018,
      humidity: 29,
      dew_point: 20.14,
      uvi: 0,
      clouds: 1,
      visibility: 9656,
      wind_speed: 6.91,
      wind_deg: 70,
      weather: [{ id: 721, main: 'Haze', description: 'haze', icon: '50n' }]
    }

    cw = CurrentWeather.new(data)
    expect(cw.datetime).to eq('2021/01/16 18:07:46')
    expect(cw.sunrise).to eq('2021/01/16 06:29:29')
    expect(cw.sunset).to eq('2021/01/16 16:51:42')
    expect(cw.temperature).to eq(data[:temp])
    expect(cw.feels_like).to eq(data[:feels_like])
    expect(cw.uvi).to eq(data[:uvi])
    expect(cw.visibility).to eq(data[:visibility])
    expect(cw.humidity).to eq(data[:humidity])
    expect(cw.conditions).to eq(data[:weather].first[:description])
    expect(cw.icon).to eq(data[:weather].first[:icon])
  end
end
