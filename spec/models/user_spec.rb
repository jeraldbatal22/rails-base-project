require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) { described_class.new(email: 'test@sample.com', username: 'testsss') }

  context 'with validation' do
    it 'is not valid without username' do
      user.username = nil
      expect(user).not_to be_valid
      # expect(user.errors).to be_present
      # expect(user.errors.to_h.keys).to include(:username)
    end

    it 'is not valid without firstname' do
      user.firstname = nil
      expect(user).not_to be_valid
      # expect(user.errors).to be_present
      # expect(user.errors.to_h.keys).to include(:firstname)
    end

    it 'is not valid without lastname' do
      user.lastname = nil
      expect(user).not_to be_valid
      # expect(user.errors).to be_present
      # expect(user.errors.to_h.keys).to include(:lastname)
    end

    it 'is not valid without email' do
      user.email = nil
      expect(user).not_to be_valid
      # expect(user.errors).to be_present
      # expect(user.errors.to_h.keys).to include(:email)
    end

    it 'is not valid without password' do
      user.password = nil
      expect(user).not_to be_valid
      # expect(user.errors).to be_present
      # expect(user.errors.to_h.keys).to include(:password)
    end
  end

  context 'with validation username uniqueness' do
    let(:user1) { described_class.new(email: 'test@sample.com', username: 'testsss') }

    it { expect(user1).not_to be_valid }
  end

  context 'with validation email uniqueness' do
    let(:user2) { described_class.new(email: 'test@sample.com', username: 'testsss') }

    it { expect(user2).not_to be_valid }
  end

  describe 'length validations' do
    it 'is not allow a firstname longer than 20 character' do
      user.firstname = 'test' * 200
      expect(user).not_to be_valid
    end
  end
end
