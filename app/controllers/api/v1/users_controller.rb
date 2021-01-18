# frozen_string_literal: true

require 'securerandom'

module Api
  module V1
    class UsersController < ApplicationController
      def create
        json = JSON.parse(request.body.string, symbolize_names: true)
        user = User.new({
                          email: json[:email],
                          password: json[:password],
                          password_confirmation: json[:password_confirmation],
                          api_key: SecureRandom.uuid
                        })
        if user.save
          render json: UserSerializer.new(user), status: :created
        else
          render json: { message: 'unsuccessful', error: user.errors.full_messages.to_sentence.to_s },
                 status: :unprocessable_entity
        end
      end
    end
  end
end
