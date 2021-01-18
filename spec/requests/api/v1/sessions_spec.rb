# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/sessions', type: :request do
  it 'should return a users info if present/authorized' do
    User.create!(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password',
      api_key: '890fhdusrjufs83jkf'
    )
    data = {
      "email": 'whatever@example.com',
      "password": 'password'
    }
    post api_v1_sessions_path, params: data, as: :json

    expect(response.status).to eq(200)
    user = JSON.parse(response.body, symbolize_names: true)
    register_user_checker(user, data[:email])
  end
end
