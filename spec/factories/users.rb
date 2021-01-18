# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    api_key { Faker::Number.unique.number(digits: 15).to_s }
    email { Faker::Internet.email }
    password { 'DIGEST' }
    password_confirmation { 'DIGEST' }
  end
end
