# frozen_string_literal: true

require 'date'

class CurrentWeather < Forecast
  attr_reader :datetime, :sunrise, :sunset, :temperature, :feels_like,
              :humidity, :uvi, :visibility, :conditions, :icon

  def initialize(data)
    @datetime = datetime_conversion(data[:dt])
    @sunrise = datetime_conversion(data[:sunrise])
    @sunset = datetime_conversion(data[:sunset])
    @temperature = data[:temp]
    @feels_like = data[:feels_like]
    @humidity = data[:humidity]
    @uvi = data[:uvi]
    @visibility = data[:visibility]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end
