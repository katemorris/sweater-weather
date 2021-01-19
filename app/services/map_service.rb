# frozen_string_literal: true

class MapService
  def self.coordinates(location)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['key'] = ENV['MQ_KEY']
      req.params['location'] = location
    end
    JSON.parse(response.body, symbolize_names: true)[:results].first[:locations].first[:displayLatLng]
  end

  def self.travel_time(origin, destination)
    response = conn.get('/directions/v2/route') do |req|
      req.params['key'] = ENV['MQ_KEY']
      req.params['from'] = origin
      req.params['to'] = destination
      req.params['narrativeType'] = 'none'
    end
    JSON.parse(response.body, symbolize_names: true)[:route][:formattedTime]
  end

  def self.coordinates_travel(origin, destination)
    conn.in_parallel do
      response1 = travel_time(origin, destination)
      response2 = coordinates(destination)
    end
    [response1, response2].map do |response|
      JSON.parse(response.body, symbolize_names: true)[:route][:formattedTime]
    end
  end

  def self.conn
    # Faraday.new('https://www.mapquestapi.com')
    Faraday.new(:url => 'https://www.mapquestapi.com') do |builder|
      builder.request  :url_encoded
      builder.response :logger
      builder.adapter  :typhoeus
    end
  end
end
