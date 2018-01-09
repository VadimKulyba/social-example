require 'rails_helper'

RSpec.feature 'user_pages_spec' do
  describe 'sing up pages' do
    subject { page }

    describe 'singup page' do
      before { visit signup_path }

      it { should have_content('Sign up') }
      it { should have_title(full_title('Sign up')) }
    end

  end
end

