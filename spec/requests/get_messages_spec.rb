require 'rails_helper'

describe "get all messages route", :type => :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user1) { FactoryBot.create(:user) }
  let!(:messages) {FactoryBot.create_list(:message, 20, from: user1.id, to: user.id)}
before {get '/api/v1/messages'}
it 'returns all messages' do
    expect(JSON.parse(response.body).size).to eq(20)
  end
it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end