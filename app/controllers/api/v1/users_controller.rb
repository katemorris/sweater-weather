# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        json = JSON.parse(request.body.string, symbolize_names: true)
        user = User.new(user_params(json))
        render json: UserSerializer.new(user)
      end

      private

      def user_params(data)
        data.permit(:email, :password, :password_confirmation)
      end
    end
  end
end
