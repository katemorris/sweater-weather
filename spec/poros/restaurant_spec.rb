# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant do
  before :each do
    @data = {
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
   }

    @restaurant = Restaurant.new(@data)
  end

  it 'that it exists' do
    expect(@restaurant.name).to eq(@data[:name])
    expect(@restaurant.address).to eq(@data[:location][:display_address])
  end
end
