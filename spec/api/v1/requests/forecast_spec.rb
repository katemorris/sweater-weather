require 'rails_helper'

RSpec.describe 'GET /api/v1/forecast?location=X', type: :request do
  it 'given a city, state, should return forecast data' do
    location = 'Killeen, TX'
    get api_v1_forecast_path, params: { location: location }

    expect(response.status).to eq(200)
    forecast = JSON.parse(response.body, symbolize_names: true)
    forecast_get_response(forecast)
  end
end
