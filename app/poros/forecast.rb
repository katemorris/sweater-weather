# frozen_string_literal: true
require 'date'

class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @id = 'null'
    @current_weather = CurrentWeather.new(data[:current])
    @daily_weather = get_daily_weather(data[:daily])
    @hourly_weather = get_hourly_weather(data[:hourly])
  end

  def get_daily_weather(data)
    data[0..4].map do |day|
      DailyWeather.new(day)
    end
  end

  def get_hourly_weather(data)
    data[0..7].map do |hour|
      HourlyWeather.new(hour)
    end
  end

  def datetime_conversion(data)
    Time.at(data).strftime('%Y/%m/%d %H:%M:%S')
  end
end
