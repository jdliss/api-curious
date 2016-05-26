require 'rails_helper'

feature 'user can log in with google' do
  scenario 'successfully' do
    visit root_path

    OmniAuth.config.test_mode = true

    OmniAuth.config.add_mock(
      :google_oauth2,
      {
        :info => {
        :email => 'test@some_test_domain.com',
        :name=>'Test User'
      }
    })

    find('#sidebar-toggle').click
    find('.item').click

    expect(page).to have_button("Generate Headline")
    expect(page).to have_button("Generate Abstract")
  end
end
