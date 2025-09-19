require 'rails_helper'

RSpec.describe 'Health Check', type: :request do
  describe 'GET /health' do
    it 'returns health status' do
      get '/health'

      expect_json_response(:ok)
      expect(json_response).to include(
        status: 'healthy',
        service: '{{project_name}}',
        timestamp: be_present
      )
    end

    it 'does not require authentication' do
      get '/health'

      expect(response).to have_http_status(:ok)
    end
  end
end