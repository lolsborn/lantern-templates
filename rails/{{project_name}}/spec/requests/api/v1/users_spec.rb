require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'GET /api/v1/users' do
    before do
      create_list(:user, 3)
      sign_in user
    end

    it 'returns list of users' do
      get '/api/v1/users'

      expect_json_response(:ok)
      expect(json_data.size).to eq(4) # 3 created + 1 signed in user
    end

    it 'includes pagination meta' do
      get '/api/v1/users'

      expect(json_meta).to include(
        :current_page,
        :per_page,
        :total_pages,
        :total_count
      )
    end
  end

  describe 'GET /api/v1/users/:id' do
    before { sign_in user }

    it 'returns the user' do
      get "/api/v1/users/#{other_user.id}"

      expect_json_response(:ok)
      expect(json_data[:attributes][:email]).to eq(other_user.email)
    end

    it 'returns 404 for non-existent user' do
      get '/api/v1/users/999999'

      expect_json_response(:not_found)
    end
  end

  describe 'POST /api/v1/users' do
    before { sign_in user }

    let(:valid_params) do
      {
        user: {
          email: 'new@example.com',
          first_name: 'New',
          last_name: 'User',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }
    end

    it 'creates a new user' do
      expect {
        post '/api/v1/users', params: valid_params
      }.to change(User, :count).by(1)

      expect_json_response(:created)
      expect(json_data[:attributes][:email]).to eq('new@example.com')
    end

    it 'returns validation errors for invalid params' do
      post '/api/v1/users', params: { user: { email: '' } }

      expect_json_response(:unprocessable_entity)
      expect(json_errors).to be_present
    end
  end

  describe 'PATCH /api/v1/users/:id' do
    before { sign_in user }

    it 'updates the user' do
      patch "/api/v1/users/#{other_user.id}", params: {
        user: { first_name: 'Updated' }
      }

      expect_json_response(:ok)
      expect(json_data[:attributes][:first_name]).to eq('Updated')
    end
  end

  describe 'DELETE /api/v1/users/:id' do
    before { sign_in user }

    it 'deletes the user' do
      expect {
        delete "/api/v1/users/#{other_user.id}"
      }.to change(User, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'GET /api/v1/me' do
    before { sign_in user }

    it 'returns current user' do
      get '/api/v1/me'

      expect_json_response(:ok)
      expect(json_data[:attributes][:email]).to eq(user.email)
    end
  end
end