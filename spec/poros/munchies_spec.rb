# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Munchies do
  before :each do
    @destination = 'Jackson Hole, WY'
    @time = '07:40:21'
    @weather = CurrentWeather.new({
      :dt=>1611077934,
      :sunrise=>1611067819,
      :sunset=>1611101826,
      :temp=>4.77,
      :feels_like=>-4.88,
      :pressure=>1030,
      :humidity=>71,
      :dew_point=>-1.8,
      :uvi=>1.42,
      :clouds=>1,
      :visibility=>10000,
      :wind_speed=>5.75,
      :wind_deg=>20,
      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}]})
      @restaurant = Restaurant.new({
        :id=>"UDejJ1hQ8x11vAvIZ1P-Cw",
        :alias=>"thai-me-up-restaurant-and-brewery-jackson",
        :name=>"Thai Me Up Restaurant & Brewery",
        :image_url=>"https://s3-media2.fl.yelpcdn.com/bphoto/wifJqL4H5THHz2pD8RK71g/o.jpg",
        :is_closed=>false,
        :url=>
          "https://www.yelp.com/biz/thai-me-up-restaurant-and-brewery-jackson?adjust_creative=Dm5ft6BJp_2HQ7pD-hxdMw&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=Dm5ft6BJp_2HQ7pD-hxdMw",
        :review_count=>415,
        :categories=>[{:alias=>"thai", :title=>"Thai"}, {:alias=>"brewpubs", :title=>"Brewpubs"}],
        :rating=>3.5,
        :coordinates=>{:latitude=>43.478632, :longitude=>-110.76107},
       :transactions=>[],
       :price=>"$$",
       :location=>
        {:address1=>"75 E Pearl Ave",
         :address2=>"",
         :address3=>"",
         :city=>"Jackson",
         :zip_code=>"83001",
         :country=>"US",
         :state=>"WY",
         :display_address=>["75 E Pearl Ave", "Jackson, WY 83001"]},
       :phone=>"+13077330005",
       :display_phone=>"(307) 733-0005",
       :distance=>1691.7029459361822
     })
    @munchies = Munchies.new(@destination, @time, @weather, @restaurant)
  end

  it 'that it exists' do
    expect(@munchies.destination_city).to eq(@destination)
    expect(@munchies.travel_time).to eq(@time)
    expect(@munchies.forecast[:temperature]).to eq(@weather.temperature)
    expect(@munchies.forecast[:summary]).to eq(@weather.conditions)
    expect(@munchies.restaurant.name).to eq(@restaurant.name)
    expect(@munchies.restaurant.address).to eq(@restaurant.address)
    expect(@munchies.id).to eq('null')
  end

  describe 'instance methods' do
    it '#weather_grabber()' do
      expected = {
        temperature: 4.77,
        summary: 'clear sky'
      }
      expect(@munchies.weather_grabber(@weather)).to eq(expected)
    end
  end
end
