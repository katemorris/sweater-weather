# frozen_string_literal: true

class Munchie
  attr_reader :destination_city, :travel_time, :forecast, :restaurant, :id

  def initialize(destination, time, weather, restaurant)
    @destination_city = destination
    @travel_time = time.nil? ? 'Impossible Route' : time
    @forecast = weather_grabber(weather)
    @restaurant = restaurant
    @id = 'null'
  end

  def weather_grabber(weather)
    if weather.blank?
      ""
    else
      {
        summary: weather.conditions,
        temperature: weather.temperature

      }
    end
  end
end
