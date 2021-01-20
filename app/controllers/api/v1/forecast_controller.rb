# frozen_string_literal: true

module Api
  module V1
    class ForecastController < ApplicationController
      def show
        if params[:location].blank?
          location_not_found
        else
          forecast = ForecastFacade.by_location(params[:location])
          render json: ForecastSerializer.new(forecast)
        end
      end
    end
  end
end
