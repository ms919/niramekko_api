require 'rails_helper'

describe 'session' do
  let(:user){ create(:user) }

  describe '#create' do
    it 'sessionが格納されること' do
      valid_params = { session: { token: auth_as(user) } }
      post '/api/v1/login', params: valid_params, as: :json
      expect(session[:user_id]).to eq(user.id)
      expect(response.status).to eq(200)
    end
  end

  describe '#destroy' do
    it 'sessionが切れること' do
      login_as(user)
      delete '/api/v1/logout'
      expect(session[:user_id]).to eq(nil)
      expect(response.status).to eq(200)
    end
  end
end