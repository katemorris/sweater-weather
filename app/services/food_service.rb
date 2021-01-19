class FoodService
  def self.restaurants(location, time, category)
    conn = Faraday.new('https://api.yelp.com')
    response = conn.get('/v3/businesses/search') do |req|
      req.headers['Authorization'] = "Bearer #{ENV['YELP_KEY']}"
      req.params['term'] = "#{category} restaurant"
      req.params['location'] = location
      req.params['limit'] = 10
      req.params['open_at'] = time
    end
    JSON.parse(response.body, symbolize_names: true)[:businesses]
  end
end
