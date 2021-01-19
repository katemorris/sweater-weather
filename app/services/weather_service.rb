# frozen_string_literal: true

class WeatherService
  def self.forecast(coords, excludes = 'minutely,alerts', unit = 'imperial')
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['appid'] = ENV['OW_KEY']
      req.params['lat'] = coords[:lat]
      req.params['lon'] = coords[:lng]
      req.params['exclude'] = excludes
      req.params['units'] = unit
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.openweathermap.org')
  end
end
