require 'rails_helper'

describe '#create' do
  it 'コンタクトメッセージがDBに登録されること' do
    valid_params = { contact: { contact_type: :request, message: "message_text" } }
    expect { post '/api/v1/contacts', params: valid_params, as: :json }.to change(Contact, :count).by(+1)
    expect(response.status).to eq(201)
 end
end
