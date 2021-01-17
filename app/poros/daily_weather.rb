# frozen_string_literal: true

class DailyWeather < Forecast
  attr_reader :date, :sunrise, :sunset, :max_temp, :min_temp,
              :conditions, :icon

  def initialize(data)
    @date = date_conversion(data[:dt])
    @sunrise = datetime_conversion(data[:sunrise])
    @sunset = datetime_conversion(data[:sunset])
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end

  def date_conversion(data)
    Time.at(data).to_date.to_s
  end
end
