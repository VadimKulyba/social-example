require 'rails_helper'

RSpec.describe 'MicropostPages', type: :request do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe 'micropost create' do
    before {
      visit root_path
      click_link('Wand to do post?')
    }

    describe 'with invalid info' do
      it 'should not create a post' do
        expect { click_button 'Post' }.not_to change(Micropost, :count)
      end
      describe 'error' do
        before { click_button 'Post' }
        it { have_content('error') }
      end
    end
    describe 'with valid info' do
      before { fill_in 'micropost_content', with: 'hello' }
      it 'should create post' do
        expect { click_button 'Post' }.to change(Micropost, :count).by(1)
      end
    end
  end
end
