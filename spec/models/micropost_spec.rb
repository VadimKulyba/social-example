require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @micropost = user.microposts.build(content: 'hello user')
  end

  subject { @micropost }
  # test params
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  # test methods
  it { should respond_to(:user) }
  # test valid
  it { should be_valid }

  describe 'when user_id not valid' do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe 'with blank content' do
    before { @micropost.content = ' ' }
    it { should_not be_valid }
  end

  describe 'with content that is too long' do
    before { @micropost.content = 'a' * 141 }
    it { should_not be_valid }
  end
end
