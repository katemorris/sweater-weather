# frozen_string_literal: true

require 'date'

class RoadTripFacade
  def self.trip_data(origin, destination)
    time = MapService.travel_time(origin, destination)
    if time
      coords = MapService.coordinates(destination)
      forecast = WeatherService.forecast(coords)
      travel_in_seconds = Time.parse(time).seconds_since_midnight
      hourly_weather = forecast[:hourly].select do |hourly|
        hourly[:dt] < (Time.now.to_i + travel_in_seconds).to_i
      end.last
      weather = HourlyWeather.new(hourly_weather)
    else
      weather = ''
    end
    RoadTrip.new(origin, destination, time, weather)
  end
end
