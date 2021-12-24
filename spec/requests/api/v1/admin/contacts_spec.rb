require 'rails_helper'

describe 'admin/contacts' do
  before do
    @contact = create(:contact)
    login_as(create(:user, :admin))
  end

  describe '#index' do
    let(:res){ JSON.parse(response.body) }
    it 'コンタクトメッセージ一覧が取得できること' do
      get '/api/v1/admin/contacts', params: { page: 1 }
      expect(res['contacts'].length).to eq(1)
      expect(res['total_pages']).to eq(1)
    end
  end

  describe '#update' do
    it 'コンタクトメッセージが更新できること' do
      valid_params = { contact: { state: :ongoing } }
      patch "/api/v1/admin/contacts/#{@contact.id}", params: valid_params
      expect(response.status).to eq(202)
    end
  end

  describe '#destroy' do
    it 'コンタクトメッセージを削除できること' do
      expect { delete "/api/v1/admin/contacts/#{@contact.id}" }.to change(Contact, :count).by(-1)
      expect(response.status).to eq(202)
    end
  end
end