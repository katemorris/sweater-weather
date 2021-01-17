# frozen_string_literal: true

class Image
  attr_reader :photo_url, :username, :user_url, :location, :id

  def initialize(data, user, search)
    @photo_url = make_url(data[:server], data[:id], data[:secret])
    @username = user[:username][:_content]
    @user_url = user[:photosurl][:_content]
    @location = search
    @id = 'null'
  end

  def make_url(server, id, secret)
    "https://live.staticflickr.com/#{server}/#{id}_#{secret}.jpg"
  end
end
