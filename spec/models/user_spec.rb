require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: 'Example', email: 'example@gmail.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  subject { @user }

  # check column
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:admin) }
  it { should respond_to(:remember_token) }
  # params for secure methods
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  # for authorize methods
  it { should respond_to(:authenticate) }
  # for microposts
  it { should respond_to(:microposts) }

  # show valid
  it { should be_valid }
  it { should_not be_admin }

  # check admin status
  describe 'with valid attribute set true' do
    before do
      @user.save!
      @user.toggle!(:admin)
    end
    it { should be_admin }
  end

  # check validation
  # name
  describe 'when name is not present' do
    before { @user.name = ' ' }
    it { should_not be_valid }
  end
  describe 'when name long' do
    before { @user.name = 'a' * 51 }
    it { should_not be_valid }
  end
  # email
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
  # password
  describe 'when password is not present' do
    before do
      @user = User.new(name: 'Example User', email: 'user@example.com',
                       password: ' ', password_confirmation: ' ')
    end
    it { should_not be_valid }
  end
  describe 'when password long' do
    before { @user.password = @user.password_confirmation = 'a' * 5 }
    it { should_not be_valid }
  end
  describe 'when password doesnt match confirmation' do
    before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end
  describe 'return value of authenticate method' do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe 'with valid password' do
      it { should eq found_user.authenticate(@user.password) }
    end
    describe 'with invalid password' do
      let(:user_for_invalid_password) { found_user.authenticate('invalid') }
      it { should_not eq user_for_invalid_password }
    end
  end
  # remember token
  describe 'remember token' do
    before { @user.save }
    it { expect(@user.remember_token).not_to be_blank }
  end
  # micropost
  describe 'associations' do
    before { @user.save }
    let!(:old_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:new_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end
    it 'sort on date test' do
      expect(@user.microposts.to_a).to eq [new_micropost, old_micropost]
    end
    it 'destroy microposts with user' do
      microposts = @user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty
      microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty
      end
    end
  end
end
