# frozen_string_literal: true

class ApplicationController < ActionController::API

  def location_not_found
    render json: { message: 'Please fill in a location.' }, status: :not_found
  end
end
