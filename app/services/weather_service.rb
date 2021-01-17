# frozen_string_literal: true

class WeatherService
  def self.forecast(coords)
    conn = Faraday.new('https://api.openweathermap.org')
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['appid'] = ENV['OW_KEY']
      req.params['lat'] = coords[:lat]
      req.params['lon'] = coords[:lng]
      req.params['exclude'] = 'minutely,alerts'
      req.params['units'] = 'imperial'
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
