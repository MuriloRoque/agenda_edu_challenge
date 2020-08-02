require 'rails_helper'

RSpec.describe Message, type: :model do

  let(:user) { FactoryBot.create(:user)}
  let(:user1) { FactoryBot.create(:user)}
  let(:message) { FactoryBot.create(:message,from: user.id,to: user1.id)}
  let(:message1) { FactoryBot.create(:message,from: user1.id,to: user.id)}
  let(:read_message) { FactoryBot.create(:message,:read,from: user.id,to: user1.id)}
  let(:archived_message) { FactoryBot.create(:message,:archived,from: user.id,to: user1.id)}

  describe 'creation' do
    it 'is valid with valid atributes' do
      expect(message).to be_valid
    end

    it 'is invalid with empty atributes' do
      message = Message.new
      expect(message).to_not be_valid
    end

    it 'is invalid without from' do
      message = FactoryBot.build(:message,:no_from)
      expect(message).to_not be_valid
    end

    it 'is invalid without to' do
      message = FactoryBot.build(:message,:no_to)
      expect(message).to_not be_valid
    end

  end


  describe 'update' do
    it 'record time when change read message' do
      message.update(status: 1)
      expect(message.visualized).to_not be_nil
    end

    it 'record time when change archive message' do
      message.update(status: 2)
      expect(message.archived).to_not be_nil
    end
  end

  describe 'message info' do
    it 'from' do
      expect(message.sender).to eq user
    end

    it 'to' do
      expect(message.receiver).to eq user1
    end
  end

  describe 'scopes' do

    it 'return non archived messages sent to a user' do
      load_messages
      expect(Message.sent_to(user1)).to eq [message,read_message]
    end

    it 'return all messages sent to a user' do
      load_messages
      expect(Message.all_sent_to(user1)).to eq [message,archived_message,read_message]
    end

    it 'return unread messages' do
      load_messages
      expect(Message.unread).to eq [message]
    end

    it 'return ordered desc messages' do
      load_messages
      expect(Message.ordered).to eq [read_message,archived_message,message]
    end

    it 'return all non arquived messages' do
      load_messages
      message1
      expect(Message.master_messages.size).to eq 3
    end
  end

  describe 'delegations' do
    it 'show sender name' do
      expect(message.sender_name).to eq user.name
    end

    it 'show sender email' do
      expect(message.sender_email).to eq user.email
    end
  end

  describe 'shoulda matchers' do
    subject(:message) { FactoryBot.create(:message)}

    it { is_expected.to validate_presence_of(:title)}
    it { is_expected.to validate_presence_of(:content)}
    it { is_expected.to validate_presence_of(:from)}
    it { is_expected.to validate_presence_of(:to)}

    it { is_expected.to belong_to(:sender)}
    it { is_expected.to belong_to(:receiver)}
  end

end

def load_messages
  message
  archived_message
  read_message
end
