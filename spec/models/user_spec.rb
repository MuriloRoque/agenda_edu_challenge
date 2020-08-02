require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryBot.create(:user)}

  describe 'creation' do
    it 'is valid with valid atributes' do
      expect(user).to be_valid
    end

    it 'is invalid with empty atributes' do
      user = User.new
      expect(user).to_not be_valid
    end

    it 'is invalid with invalid email' do
      user = FactoryBot.build(:user,:invalid_email)
      expect(user).to_not be_valid
    end

    it 'is invalid with duplicated email' do
      user2 = FactoryBot.build(:user)
      user2.email = user.email
      expect(user2).to_not be_valid
    end

  end

  describe 'shoulda matchers' do
    subject(:user) { FactoryBot.create(:user)}

    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_presence_of(:email)}

    it { is_expected.to have_many(:messages)}
  end
end
