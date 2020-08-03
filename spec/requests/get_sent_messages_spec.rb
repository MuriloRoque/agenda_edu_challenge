require 'rails_helper'

describe 'get all sent messages route', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user1) { FactoryBot.create(:user, :master) }
  let!(:messages) { FactoryBot.create_list(:message, 20, from: user1.id, to: user.id) }
  before { get '/api/v1/messages/sent', as: :json, headers: { Authorization: 'Token ADMI123456' } }
  it 'returns all messages' do
    expect(JSON.parse(response.body).size).to eq(20)
  end
  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
