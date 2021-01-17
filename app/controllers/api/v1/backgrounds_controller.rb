# frozen_string_literal: true

module Api
  module V1
    class BackgroundsController < ApplicationController
      def show
        image_data = BackgroundsFacade.by_location(params[:location])
        render json: ImageSerializer.new(image_data)
      end
    end
  end
end
