require 'rails_helper'

describe "show a message route", :type => :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user1) { FactoryBot.create(:user) }
  let!(:message) {FactoryBot.create(:message, from: user1.id, to: user.id)}
before {get "/api/v1/messages/#{message.id}"}
it 'returns a message' do
    expect(JSON.parse(response.body)['content']).to eq('Lorem ipsum')
  end
it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end