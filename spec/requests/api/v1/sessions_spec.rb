# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/sessions', type: :request do
  before :each do
    create(:user,
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    @error = 'Something went wrong, please try logging in again!'
  end
  it 'should return a users info if present/authorized' do
    data = {
      "email": 'whatever@example.com',
      "password": 'password'
    }
    post api_v1_sessions_path, params: data, as: :json

    expect(response.status).to eq(200)
    user = JSON.parse(response.body, symbolize_names: true)
    register_user_checker(user, data[:email])
  end

  it 'should return error if password is not correct' do
    data = {
      "email": 'whatever@example.com',
      "password": 'notpassword'
    }
    post api_v1_sessions_path, params: data, as: :json

    expect(response.status).to eq(422)
    message = JSON.parse(response.body, symbolize_names: true)
    expect(message[:error]).to eq(@error)
  end

  it 'should return error if email does not match' do
    data = {
      "email": 'whatever23@example.com',
      "password": 'password'
    }
    post api_v1_sessions_path, params: data, as: :json

    expect(response.status).to eq(422)
    message = JSON.parse(response.body, symbolize_names: true)
    expect(message[:error]).to eq(@error)
  end
end
