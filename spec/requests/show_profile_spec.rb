require 'rails_helper'

describe 'show a profile route', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user1) { FactoryBot.create(:user, :master) }
  let!(:messages) { FactoryBot.create_list(:message, 20, from: user1.id, to: user.id) }
  before { get 'http://localhost:3000/api/v1/profile', as: :json, headers: { Authorization: 'Token ADMI123456' } }

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
