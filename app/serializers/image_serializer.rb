# frozen_string_literal: true

class ImageSerializer
  include FastJsonapi::ObjectSerializer

  attribute :image do |image|
    {
      image_url: image.photo_url,
      location: image.location,
      credit: {
        author: image.username,
        url: image.user_url
      }
    }
  end
end
