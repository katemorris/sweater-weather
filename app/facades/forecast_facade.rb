class ForecastFacade
  def self.by_location(location)
    coords = MapService.coordinates(location)
    forecast = WeatherService.forecast(coords)
    Forecast.new(forecast)
  end
end
