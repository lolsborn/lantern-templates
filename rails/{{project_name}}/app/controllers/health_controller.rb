class HealthController < ApplicationController
  def show
    render json: {
      status: 'healthy',
      service: '{{project_name}}',
      timestamp: Time.current.iso8601
    }
  end
end