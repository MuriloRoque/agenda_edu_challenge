require 'rails_helper'

feature 'Check Messages' do

  let(:master) { FactoryBot.create(:user,:master)}
  let(:user) { FactoryBot.create(:user)}
  let(:user1) { FactoryBot.create(:user)}
  let!(:message) { FactoryBot.create(:message,to: user.id,from: user1.id)}
  let!(:message1) { FactoryBot.create(:message,to: user1.id,from: user.id)}
  let!(:archived_message) { FactoryBot.create(:message,:archived,to: user1.id,from: user.id)}

  before do
    login_as(master, :scope => :user)
  end

  scenario 'check received messages' do
    visit '/messages'
    expect(page).to have_content message.title
    expect(page).to have_content message1.title
  end

  scenario 'check sent messages' do
    visit '/archived'
    expect(page).to have_content archived_message.title
    expect(page).to_not have_content message.title
  end

end
