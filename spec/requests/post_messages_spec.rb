require 'rails_helper'
describe "post a message route", :type => :request do
before do
    post '/api/v1/messages', params: { :message => { :receiver_email => 'master@email.com', :title => 'Title', :content => 'Content'} }
  end
it 'returns the message\'s receiver e-mail' do
    expect(JSON.parse(response.body)['message']['receiver_email']).to eq('master@email.com')
  end
it 'returns the message\'s title' do
    expect(JSON.parse(response.body)['message']['title']).to eq('Title')
  end
it 'returns the message\'s content' do
    expect(JSON.parse(response.body)['message']['content']).to eq('Content')
  end
it 'returns a created status' do
    expect(response).to have_http_status(:created)
  end
end