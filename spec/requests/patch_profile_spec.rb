require 'rails_helper'

describe "update a profile route", :type => :request do
  let!(:user) { User.create( name: 'Murilo', email: 'murilo@email.com', password: '123456', password_confirmation: '123456') }
before {patch "/api/v1/profile?user[name]=Murilo2"}
it 'returns the updated profile' do
    expect(JSON.parse(response.body)['user']['name']).to eq('Murilo2')
  end
it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end