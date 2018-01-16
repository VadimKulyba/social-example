require 'rails_helper'

RSpec.feature 'user_pages_spec' do
  subject { page }

  describe 'index' do
    before do
      sign_in(FactoryGirl.create(:user))
      FactoryGirl.create(:user, name: 'Bob', email: 'bob@example.com')
      FactoryGirl.create(:user, name: 'Ben', email: 'ben@example.com')
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }
    it 'should list each user' do
      User.all.each do |user|
        expect(user).to have_selector('li', text: user.name)
      end
    end
  end

  describe '(show page) profile page' do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe '(create page) sing up page' do
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

  describe 'update page' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in(user) }
    before { visit edit_user_path(user) }

    it { should have_content('Update your page') }
    it { should have_title('Edit user') }
    it { should have_link('change', href: 'http://gravatar.com/emails') }

    describe 'with invalid information' do
      before { click_button 'Save changes' }
      it { should have_content('error') }
    end

    describe 'valid information' do
      let(:new_name) { 'new name' }
      let(:new_email) { 'newemail@gmail.com' }
      before do
        fill_in 'Name',         with: new_name
        fill_in 'Email',        with: new_email
        fill_in 'Password',     with: user.password
        fill_in 'Confirmation', with: user.password
        click_button 'Save changes'
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end

  describe 'delete links' do
    it { should_not have_link('delete') }

    describe 'user is admin' do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit users_path
      end
      it { should have_link('delete', href: users_path(User.first)) }
      it 'should be able to delete another user' do
        expect do
          click_link('delete', match: :first)
        end.to change(User, :count).by(-1)
      end
      it { should_not have_link('delete', href: user_path(admin)) }
    end
  end
end
