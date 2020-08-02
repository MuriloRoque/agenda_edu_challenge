require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  let(:user) { FactoryBot.create(:user)}
  let(:user1) { FactoryBot.create(:user)}
  let(:master) { FactoryBot.create(:user,:master)}
  let(:message) { FactoryBot.create(:message,to: user.id,from: user1.id)}
  let(:message1) { FactoryBot.create(:message,to: user1.id,from: user.id)}
  let(:read_message) { FactoryBot.create(:message,:read,to: user.id)}
  let(:archived_message) { FactoryBot.create(:message,:archived,to: user.id)}
  let(:archived_message1) { FactoryBot.create(:message,:archived,to: user1.id)}

  describe '#new' do
    before do
      sign_in user
    end

    it 'can be reached' do
      get :new
      expect(response).to render_template :new
    end

    it 'assigns a new message' do
      get :new
      expect(assigns(:message)).to be_a_new(Message)
    end
  end


  describe '#create' do
    before do
      sign_in user
    end

    it 'create a message' do
      expect {create_message}.to change(Message,:count).by(1)
    end

    it 'redirects to index on success' do
      create_message
      expect(response).to redirect_to messages_path
    end

    it 'not create a message' do
      expect {create_invalid_message}.to_not change(Message,:count)
    end

    it 'redirects to new on error' do
      create_invalid_message
      expect(response).to redirect_to new_message_path
    end
  end

  describe '#index' do
    context 'when is normal user' do
      before do
        sign_in user
      end

      it 'list all personal non archived messages' do
        message
        archived_message
        get :index
        expect(assigns(:messages)).to eq([message])
      end

      it 'can be reached' do
        get :index
        expect(response).to render_template :index
      end

    end

    context 'when is master' do
      before do
        sign_in master
      end

      it 'list all non archived messages' do
        message
        message1
        get :index
        expect(assigns(:messages).size).to eq(2)
      end
    end





  end

  describe '#show' do
    context 'when is normal user' do
      before do
        sign_in user
      end


      it 'find the message' do
        get :show , params: {id: message.id}
        expect(assigns(:message)).to eq(message)
      end

      it 'can be reached' do
        get :show, params: {id: message.id}
        expect(response).to render_template :show
      end

      it 'update status to read' do
        get :show , params: {id: message.id}
        message.reload
        expect(message.status).to eq 'read'
      end

      it 'update visualized date' do
        get :show , params: {id: message.id}
        message.reload
        expect(message.visualized).to_not be_nil
      end
    end

    context 'when is master' do
      before do
        sign_in master
      end

      it 'find the message' do
        get :show , params: {id: message.id}
        expect(assigns(:message)).to eq(message)
      end

      it 'does not update status to read' do
        get :show , params: {id: message.id}
        message.reload
        expect(message.status).to eq 'unread'
      end

      it 'does not update visualized date' do
        get :show , params: {id: message.id}
        message.reload
        expect(message.visualized).to be_nil
      end

    end

  end

  describe '#archive_multiple' do
    before do
      sign_in user
    end

    it 'archives multiples messages' do
      patch 'archive_multiple', params: {messages_ids: [message.id,read_message.id], format: :js}
      expect(message.reload.archived?).to eq true
    end
  end

  describe '#archive' do
    before do
      sign_in user
    end

    it 'archives one messages' do
      patch 'archive', params: {title: message.title, format: :js}
      expect(message.reload.archived?).to eq true
    end
  end

  describe '#archived' do
    before do
      sign_in master
    end

    it 'list all archived messages' do
      archived_message
      archived_message1
      message
      read_message
      get :archived
      expect(assigns(:messages).size).to eq 2
    end
  end

  describe '#sent' do
    before do
      sign_in user
    end

    it 'show all sent messages' do
      message
      message1
      get :sent
      expect(assigns(:messages)).to eq [message1]
    end
  end
end

def create_message
  post :create, params:
        {message: {title: 'Mensagem 1', content: 'Conteudo da mensagem', receiver_email: user1.email}}
end

def create_invalid_message
  post :create, params:
        {message: {title: 'Mensagem 1', content: 'Conteudo da mensagem'}}
end
