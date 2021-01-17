# frozen_string_literal: true

class MapService
  def self.coordinates(location)
    conn = Faraday.new('https://www.mapquestapi.com')
    response = conn.get("/geocoding/v1/address?key=#{ENV['MQ_KEY']}&location=#{location}")
    JSON.parse(response.body, symbolize_names: true)[:results].first[:locations].first[:displayLatLng]
  end
end
