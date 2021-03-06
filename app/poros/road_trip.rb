# frozen_string_literal: true

class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta, :id

  def initialize(origin, destination, time, weather)
    @start_city = origin
    @end_city = destination
    @travel_time = time.nil? ? 'Impossible Route' : time
    @weather_at_eta = weather_grabber(weather)
    @id = 'null'
  end

  def weather_grabber(weather)
    if weather.blank?
      {
        temperature: 'none',
        conditions: 'none'
      }
    else
      {
        temperature: weather.temperature,
        conditions: weather.conditions
      }
    end
  end
end
