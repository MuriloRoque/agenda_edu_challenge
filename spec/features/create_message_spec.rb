require 'rails_helper'

feature 'Create Message' do

  let(:user) { FactoryBot.create(:user)}

  before do
    login_as(user, :scope => :user)
  end

  scenario 'user creates a new message' do
    visit '/messages/new'
    fill_in 'message[receiver_email]', with: user.email
    fill_in 'message[title]', with: 'Assunto 1'
    fill_in 'message[content]', with: 'Conteudo 1'
    click_button 'Enviar'
    expect(page).to have_current_path(messages_path)
    expect(page).to have_content 'Assunto 1'
  end

  scenario 'user creates a invalid message' do
    visit '/messages/new'
    fill_in 'message[receiver_email]', with: 'email'
    fill_in 'message[title]', with: 'Assunto 1'
    fill_in 'message[content]', with: 'Conteudo 1'
    click_button 'Enviar'
    expect(page).to have_current_path(new_message_path)
    expect(page).to have_content 'Escreva a mensagem.'
  end
end
