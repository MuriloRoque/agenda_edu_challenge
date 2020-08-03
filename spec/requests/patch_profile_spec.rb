require 'rails_helper'

describe 'update a profile route', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user1) { FactoryBot.create(:user, :master) }
  let!(:messages) { FactoryBot.create_list(:message, 20, from: user1.id, to: user.id) }
  before do
    patch 'http://localhost:3000/api/v1/profile',
          params: { user: { name: 'Murilo' } },
          as: :json,
          headers: { Authorization: 'Token ADMI123456' }
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
