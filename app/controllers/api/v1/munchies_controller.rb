# frozen_string_literal: true

module Api
  module V1
    class MunchiesController < ApplicationController
      def create
        data = MunchiesFacade.trip_data(params[:start], params[:end], params[:food])
        render json: MunchiesSerializer.new(data)
      end
    end
  end
end
