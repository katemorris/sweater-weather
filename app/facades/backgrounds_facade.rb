class BackgroundsFacade
  def self.by_location(location)
    image_data = ImageService.location_images(location)
    user = ImageService.user_data(image_data[:owner])
    Image.new(image_data, user, location)
  end
end
