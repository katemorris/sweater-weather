# frozen_string_literal: true

module Api
  module V1
    class ForecastController < ApplicationController
      def show
        forecast = ForecastFacade.by_location(params[:location])
        render json: ForecastSerializer.new(forecast).serialized_json
      end
    end
  end
end
