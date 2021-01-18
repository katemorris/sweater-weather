# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/users', type: :request do
  it 'should register a user' do
    data = {
      "email": 'whatever@example.com',
      "password": 'password',
      "password_confirmation": 'password'
    }
    post api_v1_users_path, params: data, as: :json

    expect(response.status).to eq(201)
    user = JSON.parse(response.body, symbolize_names: true)
    register_user_checker(user, data[:email])
  end
end
