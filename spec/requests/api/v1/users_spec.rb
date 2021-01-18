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

  it 'non-matching passwords will receive error' do
    data = {
      "email": 'whatever@example.com',
      "password": 'password',
      "password_confirmation": 'nothinghere'
    }
    post api_v1_users_path, params: data, as: :json

    expect(response.status).to eq(422)
    message = JSON.parse(response.body, symbolize_names: true)
    expect(message[:error]).to eq("Password confirmation doesn't match Password")
  end

  it 'will get error if user email is duplicated' do
    user = create(:user)
    data = {
      "email": user.email,
      "password": 'password',
      "password_confirmation": 'password'
    }
    post api_v1_users_path, params: data, as: :json

    expect(response.status).to eq(422)
    message = JSON.parse(response.body, symbolize_names: true)
    expect(message[:error]).to eq("Email has already been taken")
  end
end
