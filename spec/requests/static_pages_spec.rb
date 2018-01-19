require 'rails_helper'
require_relative '../support/utilities'

RSpec.feature 'static_pages_spec' do
  describe 'Static pages' do
    subject { page }

    it 'should have the right links on the layout' do
      visit root_path
      click_link 'About'
      expect(page).to have_title(full_title('About Us'))
      click_link 'Help'
      expect(page).to have_title(full_title('Help'))
      click_link 'Contact'
      expect(page).to have_title(full_title('Contact'))

      visit new_user_path
      expect(page).to have_title(full_title('Sign up'))
    end

    describe 'Home page' do
      before { visit root_path }

      it { should have_content('Sample App') }
      it { should have_title(full_title('Home')) }

      describe  do
        let(:user) { FactoryGirl.create(:user) }
        before do
          FactoryGirl.create(:micropost, user: user, content: "Hi")
          FactoryGirl.create(:micropost, user: user, content: "Hello")
          sign_in user
          visit root_path
        end

        it "should render feed" do
          user.feed.each do |item|
            expect(page).to have_selector("li##{item.id}", text: item.content)
          end
        end
      end
    end

    describe 'Help page' do
      before { visit help_path }

      it { should have_content('Help') }
      it { should have_title(full_title('Help')) }
    end

    describe 'About page' do
      before { visit about_path }

      it { should have_content('About') }
      it { should have_title(full_title('About Us')) }
    end

    describe 'Contact page' do
      before { visit contact_path }

      it { should have_selector('h1', text: 'Contact') }
      it { should have_title(full_title('Contact')) }
    end
  end
end
