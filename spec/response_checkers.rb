# frozen_string_literal: true

module ResponseCheckers
  def forecast_get_response(forecast)
    # Main
    expect(forecast).to have_key(:data)
    expect(forecast[:data]).to have_key(:id)
    expect(forecast[:data][:id]).to eq('null')
    expect(forecast[:data]).to have_key(:type)
    expect(forecast[:data][:type]).to eq('forecast')
    # Attributes
    expect(forecast[:data]).to have_key(:attributes)
    expect(forecast[:data][:attributes]).to be_a Hash

    # Current Weather
    expect(forecast[:data][:attributes]).to have_key(:current_weather)
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:datetime)
    expect(forecast[:data][:attributes][:current_weather][:datetime]).to be_a String
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:sunrise)
    expect(forecast[:data][:attributes][:current_weather][:sunrise]).to be_a String
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:sunset)
    expect(forecast[:data][:attributes][:current_weather][:sunset]).to be_a String
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:temperature)
    expect(forecast[:data][:attributes][:current_weather][:temperature]).to be_a Float
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:feels_like)
    expect(forecast[:data][:attributes][:current_weather][:feels_like]).to be_a Float
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:humidity)
    expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_a Numeric
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:uvi)
    expect(forecast[:data][:attributes][:current_weather][:uvi]).to be_a Numeric
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:visibility)
    expect(forecast[:data][:attributes][:current_weather][:visibility]).to be_a Numeric
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:conditions)
    expect(forecast[:data][:attributes][:current_weather][:conditions]).to be_a String
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:icon)
    expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a String

    # Daily Weather
    expect(forecast[:data][:attributes]).to have_key(:daily_weather)
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:date)
    expect(forecast[:data][:attributes][:daily_weather].first[:date]).to be_a String
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:sunrise)
    expect(forecast[:data][:attributes][:daily_weather].first[:sunrise]).to be_a String
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:sunset)
    expect(forecast[:data][:attributes][:daily_weather].first[:sunset]).to be_a String
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:max_temp)
    expect(forecast[:data][:attributes][:daily_weather].first[:max_temp]).to be_a Float
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:min_temp)
    expect(forecast[:data][:attributes][:daily_weather].first[:min_temp]).to be_a Float
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:conditions)
    expect(forecast[:data][:attributes][:daily_weather].first[:conditions]).to be_a String
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key(:icon)
    expect(forecast[:data][:attributes][:daily_weather].first[:icon]).to be_a String
    # Hourly Weather
    expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
    expect(forecast[:data][:attributes][:hourly_weather].first).to have_key(:time)
    expect(forecast[:data][:attributes][:hourly_weather].first[:time]).to be_a String
    expect(forecast[:data][:attributes][:hourly_weather].first).to have_key(:wind_speed)
    expect(forecast[:data][:attributes][:hourly_weather].first[:wind_speed]).to be_a String
    expect(forecast[:data][:attributes][:hourly_weather].first).to have_key(:wind_direction)
    expect(forecast[:data][:attributes][:hourly_weather].first[:wind_direction]).to be_a String
    expect(forecast[:data][:attributes][:hourly_weather].first).to have_key(:temperature)
    expect(forecast[:data][:attributes][:hourly_weather].first[:temperature]).to be_a Float
    expect(forecast[:data][:attributes][:hourly_weather].first).to have_key(:conditions)
    expect(forecast[:data][:attributes][:hourly_weather].first[:conditions]).to be_a String
    expect(forecast[:data][:attributes][:hourly_weather].first).to have_key(:icon)
    expect(forecast[:data][:attributes][:hourly_weather].first[:icon]).to be_a String
    # Not There Expectations
    expect(forecast[:data][:attributes]).to_not have_key(:minutely_weather)
    expect(forecast[:data][:attributes]).to_not have_key(:alerts)
  end

  def register_user_checker(user, email)
    expect(user).to be_a Hash
    expect(user).to have_key(:data)
    expect(user[:data]).to be_a Hash

    expect(user[:data]).to have_key(:type)
    expect(user[:data][:type]).to be_a String
    expect(user[:data][:type]).to eq('user')

    expect(user[:data]).to have_key(:id)
    expect(user[:data][:id]).to be_a String

    expect(user[:data]).to have_key(:attributes)
    expect(user[:data][:attributes]).to have_key(:email)
    expect(user[:data][:attributes][:email]).to eq(email)

    expect(user[:data][:attributes]).to have_key(:api_key)
    expect(user[:data][:attributes]).to_not have_key(:password)
    expect(user[:data][:attributes]).to_not have_key(:password_confirmation)
  end

  def road_trip_checker(trip)
    expect(trip).to be_a Hash
    expect(trip).to have_key(:data)
    expect(trip[:data]).to be_a Hash

    expect(trip[:data]).to have_key(:type)
    expect(trip[:data][:type]).to be_a String
    expect(trip[:data][:type]).to eq('road_trip')

    expect(trip[:data]).to have_key(:id)
    expect(trip[:data][:id]).to be_a String
    expect(trip[:data][:id]).to eq('null')

    expect(trip[:data]).to have_key(:attributes)
    expect(trip[:data][:attributes]).to have_key(:start_city)
    expect(trip[:data][:attributes][:start_city]).to be_a String

    expect(trip[:data][:attributes]).to have_key(:end_city)
    expect(trip[:data][:attributes][:end_city]).to be_a String

    expect(trip[:data][:attributes]).to have_key(:travel_time)
    expect(trip[:data][:attributes][:travel_time]).to be_a String

    expect(trip[:data][:attributes]).to have_key(:weather_at_eta)
    expect(trip[:data][:attributes][:weather_at_eta]).to be_a Hash
    expect(trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    expect(trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a Numeric

    expect(trip[:data][:attributes][:weather_at_eta]).to_not have_key(:sunrise)
  end
end
