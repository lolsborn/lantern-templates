class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken if defined?(DeviseTokenAuth)

  before_action :authenticate_user!, unless: :health_check?
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Exception handling
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

  private

  def health_check?
    controller_name == 'health'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def not_found
    render json: { error: 'Not found' }, status: :not_found
  end

  def bad_request
    render json: { error: 'Bad request' }, status: :bad_request
  end

  def unprocessable_entity(exception)
    render json: {
      error: 'Validation failed',
      details: exception.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  def render_error(message, status = :bad_request)
    render json: { error: message }, status: status
  end

  def render_success(data = nil, status = :ok)
    response = { success: true }
    response[:data] = data if data
    render json: response, status: status
  end
end