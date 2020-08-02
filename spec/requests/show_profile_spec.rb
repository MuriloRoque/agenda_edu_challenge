require 'rails_helper'

describe "show a message route", :type => :request do
  let!(:user) { User.create( name: 'Murilo', email: 'murilo@email.com', password: '123456', password_confirmation: '123456') }
before {get "/api/v1/profile"}
it 'returns the profile' do
    expect(JSON.parse(response.body)['user']['name']).to eq('Murilo')
  end
it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end