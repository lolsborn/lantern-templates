class ErrorsController < ApplicationController
  def not_found
    render json: { error: 'Not found' }, status: :not_found
  end

  def internal_server_error
    render json: { error: 'Internal server error' }, status: :internal_server_error
  end
end