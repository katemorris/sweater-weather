# frozen_string_literal: true

require 'date'

class RoadTripFacade
  def self.trip_data(origin, destination)
    time = MapService.travel_time(origin, destination)
    weather = if time
                HourlyWeather.new(hourly_weather(destination, time))
              else
                ''
              end
    RoadTrip.new(origin, destination, time, weather)
  end

  def self.forecast(destination)
    exclude = 'daily,current,minutely,alerts'
    WeatherService.forecast(MapService.coordinates(destination), exclude)
  end

  def self.travel_in_seconds(time)
    time_breakdown = time.split(':')
    if time_breakdown.first.to_i > 24
      hours = (time_breakdown.first.to_i - 24).to_s
      time_minus_day = time.gsub(time_breakdown.first, hours)
      86_400 + Time.parse(time_minus_day).seconds_since_midnight
    else
      Time.parse(time).seconds_since_midnight
    end
  end

  def self.hourly_weather(destination, time)
    forecast(destination)[:hourly].select do |hourly|
      hourly[:dt] < (Time.now.to_i + travel_in_seconds(time)).to_i
    end.last
  end
end
