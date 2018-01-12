require 'rails_helper'

RSpec.feature 'user_pages_spec' do
  subject { page }

  describe 'profile page' do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe 'sing up page' do
    before { visit new_user_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }

    let(:submit) { 'Create new account' }

    describe 'with invalid information input' do
      it { expect { click_button submit }.not_to change(User, :count) }
    end
    describe 'with valid information' do
      before do
        fill_in 'Name',         with: 'Example User'
        fill_in 'Email',        with: 'user@example.com'
        fill_in 'Password',     with: 'foobar'
        fill_in 'Confirmation', with: 'foobar'
      end
      it { expect { click_button submit }.to change(User, :count).by(1) }
    end
  end
end
