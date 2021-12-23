require 'rails_helper'

describe 'user' do
  let(:user){ create(:user) }

  describe '#show' do
    let(:res){ JSON.parse(response.body) }
    context 'laughed_videosが2つの場合' do
      let(:user_without_revenge){ create(:user_without_revenge) }
      it 'ログイン中のユーザー情報が返されること' do
        login_as(user_without_revenge)
        get '/api/v1/user'
        expect(res['user']['name']).to eq(user_without_revenge.name)
        expect(res['total_score']).to eq(0.0)
        expect(res['game_results'].length).to eq(0)
        expect(res['revenge_flg']).to eq(false)
      end
    end
    context 'laughed_videosが3つの場合' do
      let(:user_with_revenge){ create(:user_with_revenge) }
      it 'ログイン中のユーザー情報が返されること' do
        login_as(user_with_revenge)
        get '/api/v1/user'
        expect(res['user']['name']).to eq(user_with_revenge.name)
        expect(res['total_score']).to eq(300.0)
        expect(res['game_results']['soil']).to eq(1)
        expect(res['revenge_flg']).to eq(true)
      end
    end
  end

  describe '#update' do
    it 'ユーザー情報が更新されること' do
      login_as(user)
      valid_params = { user: { name: 'update_name' } }
      patch '/api/v1/user', params: valid_params, as: :json
      expect(User.find(user.id).name).to eq('update_name')
      expect(response.status).to eq(202)
    end
  end

  describe '#destroy' do
    it 'ユーザーが削除され、sessionが切れること' do
      login_as(user)
      expect { delete '/api/v1/user' }.to change(User, :count).by(-1)
      expect(session[:user_id]).to eq(nil)
      expect(response.status).to eq(202)
    end
  end
end