require 'rails_helper'

feature 'Check Messages' do

  let(:user) { FactoryBot.create(:user)}
  let(:user1) { FactoryBot.create(:user)}
  let!(:message) { FactoryBot.create(:message,to: user.id,from: user1.id)}
  let!(:message1) { FactoryBot.create(:message,to: user.id,from: user1.id)}

  before do
    login_as(user, :scope => :user)
  end

  # need to update phantomjs on heroku
  # scenario 'delete one message', js: true do
  #   visit '/messages'
  #   expect(page).to have_content message.title
  #   all('.single_archive').last.click
  #   expect(page).to_not have_content message.title
  # end

  scenario 'delete multiple messages', js: true do
    visit '/messages'
    expect(page).to have_content message.title
    expect(page).to have_content message1.title
    all(:css, ".messages_ids").first.set(true)
    all(:css, ".messages_ids").last.set(true)
    click_on 'Excluir Selecionadas'
    expect(page).to_not have_content message.title
    expect(page).to_not have_content message1.title
  end
end
