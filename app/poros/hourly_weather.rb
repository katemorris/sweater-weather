class HourlyWeather < Forecast
  attr_reader :time, :temperature, :wind_speed, :wind_direction,
              :conditions, :icon
  def initialize(data)
    @time = time_conversion(data[:dt])
    @temperature = data[:temp]
    @wind_speed = data[:wind_speed].to_s
    @wind_direction = get_wind_direction(data[:wind_deg]) # convert to direction
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end

  def time_conversion(data)
    Time.at(data).strftime("%k:%M")
  end

  def get_wind_direction(degrees)
    val = (degrees / 22.5) + 0.5
    directions = ["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
    directions[(val % 16)]
  end
end
