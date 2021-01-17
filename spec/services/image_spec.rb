# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageService do
  describe 'class methods' do
    it '.location_images()' do
      VCR.use_cassette('sample_image_data') do
        location = 'Johnson City, TN'
        response = ImageService.location_images(location)

        expect(response).to be_a Hash

        expect(response).to have_key(:owner)
        expect(response).to have_key(:id)
        expect(response).to have_key(:secret)
        expect(response).to have_key(:server)
        expect(response).to_not have_key(:photos)
        expect(response).to_not have_key(:photo)
      end
    end

    it '.user_data()' do
      VCR.use_cassette('sample_user_data') do
        owner_id = '53158134@N02'
        response = ImageService.user_data(owner_id)

        expect(response).to be_a Hash
        expect(response).to have_key(:username)
        expect(response).to have_key(:photosurl)
        expect(response).to_not have_key(:person)
      end
    end
  end
end
