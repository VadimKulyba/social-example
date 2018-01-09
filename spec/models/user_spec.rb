require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = User.new(name: 'Example', email: 'example@gmail.com') }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  # show valid
  it { should be_valid }

  describe 'when name is not present' do
    before { @user.name = ' ' }
    it { should_not be_valid }
  end
  describe 'when name long' do
    before { @user.name = 'a' * 51 }
    it { should_not be_valid }
  end
  describe 'when email is not present' do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end
  describe 'when email long' do
    before { @user.email = 'a' * 26 }
    it { should_not be_valid }
  end
  describe 'when email address is already taken' do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save # false if repeat
    end

    it { should_not be_valid }
  end
end
