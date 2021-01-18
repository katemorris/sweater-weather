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

  def self.conn
    Faraday.new('https://www.mapquestapi.com')
  end
end
