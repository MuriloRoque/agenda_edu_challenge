require 'rails_helper'

describe 'post a message route', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user1) { FactoryBot.create(:user, :master) }
  let!(:messages) { FactoryBot.create_list(:message, 20, from: user1.id, to: user.id) }
  before do
    post 'http://localhost:3000/api/v1/messages',
         params: { message: { receiver_email: 'master@email.com',
                              title: 'Title',
                              content: 'Content' } },
         as: :json,
         headers: { Authorization: 'Token ADMI123456' }
  end

  it 'returns a 200 status' do
    expect(response.status).to eq(200)
  end
end
