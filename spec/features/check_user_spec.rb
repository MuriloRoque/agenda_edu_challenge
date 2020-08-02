require 'rails_helper'

feature 'Check Users' do

  let(:master) { FactoryBot.create(:user,:master)}
  let(:user) { FactoryBot.create(:user)}
  let(:user1) { FactoryBot.create(:user)}
  let!(:message) { FactoryBot.create(:message,to: user.id,from: user1.id)}
  let!(:message1) { FactoryBot.create(:message,to: user1.id,from: user.id)}
  let!(:archived_message) { FactoryBot.create(:message,:archived,to: user1.id,from: user.id)}

  before do
    login_as(master, :scope => :user)
  end


  scenario 'list all users' do
    visit '/users'

    expect(page).to have_content user.name
    expect(page).to have_content user1.name
  end

  scenario 'click one user' do
    visit '/users'

    click_on user.name

    expect(page).to have_content 'Recebidas'
  end

end
