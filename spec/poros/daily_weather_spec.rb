# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyWeather do
  before :each do
    @data = {
      :dt=>1610820000,
      :sunrise=>1610803769,
      :sunset=>1610841102,
      :temp=>{:day=>51.67, :min=>36.3, :max=>56.84, :night=>45.93, :eve=>46.2, :morn=>36.79},
      :feels_like=>{:day=>44.42, :night=>38.59, :eve=>41.2, :morn=>28.72},
      :pressure=>1021,
      :humidity=>42,
      :dew_point=>21.85,
      :wind_speed=>5.88,
      :wind_deg=>308,
      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
      :clouds=>0,
      :pop=>0,
      :uvi=>3.52
    }

    @dw = DailyWeather.new(@data)
  end

  it "that it exists" do
    expect(@dw.date).to eq("2021-01-16")
    expect(@dw.sunrise).to eq("Sat, 16 Jan 2021 06:29:29 -0700")
    expect(@dw.sunset).to eq("Sat, 16 Jan 2021 16:51:42 -0700")
    expect(@dw.max_temp).to eq(@data[:temp][:max])
    expect(@dw.min_temp).to eq(@data[:temp][:min])
    expect(@dw.conditions).to eq(@data[:weather].first[:description])
    expect(@dw.icon).to eq(@data[:weather].first[:icon])
  end

  describe 'instance methods' do
    it '#date_conversion()' do
      data = 1610820000
      expect(@dw.date_conversion(data)).to eq("2021-01-16")
    end
  end
end
