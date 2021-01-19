# frozen_string_literal: true

class MunchieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :destination_city, :travel_time, :forecast, :restaurant
end
