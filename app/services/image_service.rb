class ImageService
  def self.location_images(location)
    response = conn.get("/services/rest/") do |req|
      req.params['api_key'] = ENV['FLICKR_KEY']
      req.params['format'] = "json"
      req.params['method'] = 'flickr.photos.search'
      req.params['text'] = location
      req.params['safe_search'] = 1
      req.params['per_page'] = 1
      req.params['nojsoncallback'] = 1
    end
    JSON.parse(response.body, symbolize_names: true)[:photos][:photo].first
  end

  def self.user_data(user_id)
    response = conn.get("/services/rest/") do |req|
      req.params['api_key'] = ENV['FLICKR_KEY']
      req.params['format'] = "json"
      req.params['method'] = 'flickr.people.getInfo'
      req.params['user_id'] = user_id
      req.params['nojsoncallback'] = 1
    end
    JSON.parse(response.body, symbolize_names: true)[:person]
  end

  private

  def self.conn
    Faraday.new('https://api.flickr.com')
  end
end
