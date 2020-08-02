require 'rails_helper'

feature 'Check Messages' do

  let(:user) { FactoryBot.create(:user)}
  let(:user1) { FactoryBot.create(:user)}
  let!(:message) { FactoryBot.create(:message,to: user.id,from: user1.id)}
  let!(:message1) { FactoryBot.create(:message,to: user1.id,from: user.id)}

  before do
    login_as(user, :scope => :user)
  end

  scenario 'check received messages' do
    visit '/messages'
    expect(page).to have_content message.title
    expect(page).to_not have_content message1.title
  end

  scenario 'check sent messages' do
    visit '/messages/sent'
    expect(page).to have_content message1.title
    expect(page).to_not have_content message.title
  end

  scenario 'click on one message' do
    visit '/messages'
    click_link message.title
    expect(page).to have_content message.content
  end

end
