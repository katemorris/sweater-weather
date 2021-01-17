# frozen_string_literal: true

require 'rails_helper'

describe BackgroundsFacade do
  describe 'class methods' do
    it '.by_location()' do
      VCR.use_cassette('backgrounds_facade') do
        location = 'New Bern, NC'
        response = BackgroundsFacade.by_location(location)
        expect(response).to be_an Image
      end
    end
  end
end
