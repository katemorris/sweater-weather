# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      def create
        json = JSON.parse(request.body.string, symbolize_names: true)
        user = User.find_by(email: json[:email])
        if user&.authenticate(json[:password])
          render json: UserSerializer.new(user)
        else
          render json: {
            message: 'unsuccessful',
            error: 'Something went wrong, please try logging in again!'
          },
                 status: :unprocessable_entity
        end
      end
    end
  end
end
