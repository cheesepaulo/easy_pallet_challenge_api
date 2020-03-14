class Api::V1::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |msg|
    render(json: { message: msg }, status: :not_found)
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render(json: { message: exception.param }, status: :bad_request)
  end
end
