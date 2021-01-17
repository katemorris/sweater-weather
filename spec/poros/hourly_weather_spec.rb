# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HourlyWeather do
  before :each do
    @data = {
      :dt=>1610841600,
      :temp=>53.08,
      :feels_like=>44.98,
      :pressure=>1017,
      :humidity=>17,
      :dew_point=>11.88,
      :uvi=>0,
      :clouds=>1,
      :visibility=>10000,
      :wind_speed=>4.05,
      :wind_deg=>119,
      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01n"}],
      :pop=>0
    }

    @hw = HourlyWeather.new(@data)
  end

  it "that it exists" do
    expect(@hw.time).to eq("17:00")
    expect(@hw.temperature).to eq(@data[:temp])
    expect(@hw.wind_speed).to eq(@data[:wind_speed].to_s)
    expect(@hw.wind_direction).to eq('ESE')
    expect(@hw.conditions).to eq(@data[:weather].first[:description])
    expect(@hw.icon).to eq(@data[:weather].first[:icon])
  end

  describe 'instance methods' do
    it '#time_conversion()' do
      data = 1610841600
      expect(@hw.time_conversion(data)).to eq("17:00")
    end

    it '#get_wind_direction()' do
      data = 119
      expect(@hw.get_wind_direction(data)).to eq("ESE")
    end
  end
end
