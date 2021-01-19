# frozen_string_literal: true

require 'date'

class MunchiesFacade
  def self.trip_data(origin, destination, food_type)
    time = MapService.travel_time(origin, destination)
    weather = weather_available?(destination, time)
    restaurant = first_open(destination, food_type, time)
    Munchie.new(destination, time, weather, restaurant)
  end

  def self.first_open(destination, food_type, time)
    set = FoodService.restaurants(destination, time_of_arrival(time), food_type)
    selected = set.select do |restaurant|
      restaurant[:is_closed] == false
    end.first
    Restaurant.new(selected)
  end

  def self.forecast(destination)
    WeatherService.forecast(MapService.coordinates(destination))
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

  def self.weather_available?(destination, time)
    if time
      CurrentWeather.new(forecast(destination)[:current])
    else
      ''
    end
  end

  def self.time_of_arrival(time)
    if time
      (Time.now.to_i + travel_in_seconds(time)).to_i
    else
      ''
    end
  end

end
