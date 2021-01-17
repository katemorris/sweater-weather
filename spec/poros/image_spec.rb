# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image do
  before :each do
    @location = 'Killeen, TX'
    @image_data = {
      :id=>"50841175836",
      :owner=>"53158134@N02",
      :secret=>"94e3d109de",
      :server=>"65535",
      :farm=>66,
      :title=>"N42RA (Rio Airways)",
      :ispublic=>1,
      :isfriend=>0,
      :isfamily=>0}
    @user_data = {
      :id=>"53158134@N02",
      :nsid=>"53158134@N02",
      :pro_badge=>"standard",
      :expire=>"0",
      :username=>{:_content=>"Steelhead 2010"},
      :realname=>{:_content=>"Reinhard Zinabold"},
      :location=>{:_content=>"Ancaster/Ontario, Canada"},
      :photosurl=>{:_content=>"https://www.flickr.com/photos/steelhead2010/"},
      :profileurl=>{:_content=>"https://www.flickr.com/people/steelhead2010/"},
    }
    @image = Image.new(@image_data, @user_data, @location)
  end

  it 'that it exists' do
    expect(@image.photo_url).to eq('https://live.staticflickr.com/65535/50841175836_94e3d109de.jpg')
    expect(@image.username).to eq(@user_data[:username][:_content])
    expect(@image.user_url).to eq(@user_data[:photosurl][:_content])
    expect(@image.location).to eq(@location)
    expect(@image.id).to eq('null')
  end

  describe 'instance methods' do
    it '#make_url()' do
      server = @image_data[:server]
      id = @image_data[:id]
      secret = @image_data[:secret]
      expect(@image.make_url(server, id, secret)).to eq('https://live.staticflickr.com/65535/50841175836_94e3d109de.jpg')
    end
  end
end
