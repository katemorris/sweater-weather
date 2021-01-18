# frozen_string_literal: true

module Api
  module V1
    class RoadTripController < ApplicationController
      def create
        json = JSON.parse(request.body.string, symbolize_names: true)
        if User.find_by(api_key: json[:api_key])
          roadtrip = RoadTripFacade.trip_data(json[:origin], json[:destination])
          render json: RoadTripSerializer.new(roadtrip)
        else
          render json: { message: 'unauthorized' }, status: :unauthorized
        end
      end
    end
  end
end
