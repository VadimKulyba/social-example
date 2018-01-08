require 'rails_helper'

RSpec.feature "static_pages_spec" do
  scenario "home" do
    visit '/static_pages/home'
    expect(page).to have_content('Sample App')
  end
end
