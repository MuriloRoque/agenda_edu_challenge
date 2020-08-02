require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { FactoryBot.create(:user)}
  let(:user1) { FactoryBot.create(:user)}
  let(:master) { FactoryBot.create(:user,:master)}
  let(:message) { FactoryBot.create(:message,to: user.id,from: user1.id)}
  let(:message1) { FactoryBot.create(:message,to: user1.id,from: user.id)}

  describe '#edit' do
    before do
      sign_in user
    end

    it 'can be reached' do
      get :edit, params: {id: user.id}
      expect(response).to render_template :edit
    end

    it 'find the user' do
      get :edit, params: {id: user.id}
      expect(assigns(:user)).to eq user
    end
  end

  describe '#update' do
    before do
      sign_in user
    end

    it 'find the user' do
      get :update, params: { id: user.id, user: {name: 'Editado',email: 'editado@email.com'}}
      expect(assigns(:user)).to eq user
    end

    it 'updates a user info' do
      patch :update, params: { id: user.id, user: {name: 'Editado',email: 'editado@email.com'}}
      user.reload
      expect([user.name,user.email]).to eq ['Editado','editado@email.com']
    end

    it 'updates user password' do
      patch :update, params: { id: user.id, user: {password: '098765',password_confirmation: '098765'}}
      user.reload
      expect(user.valid_password?('098765')).to eq true
    end

    it 'redirect to success page' do
      patch :update, params: { id: user.id, user: {name: 'Editado',email: 'editado@email.com'}}
      expect(response).to redirect_to messages_path
    end

    it 'redirect to edit on error' do
      patch :update, params: { id: user.id, user: {name: 'Editado',email: 'email.com'}}
      expect(response).to redirect_to edit_user_path(id: user.id)
    end

  end

  describe '#index' do
    before do
      sign_in master
    end

    it 'list all personal non archived messages' do
      user
      get :index
      expect(assigns(:users)).to eq [user]
    end

    it 'can be reached' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe '#messages' do
    before do
      sign_in master
      message
      message1
    end

    it 'show user sended messages' do
      get :messages, params: {id: user.id}
      expect(assigns(:sent)).to eq [message1]
    end

    it 'show user received messages' do
      get :messages, params: {id: user.id}
      expect(assigns(:received)).to eq [message]
    end
  end
end
