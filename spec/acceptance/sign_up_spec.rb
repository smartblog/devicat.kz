require 'rails_helper'

feature 'User Sign-Up', %q{
  To Login user
  need to sign_up on site
} do

  given(:user) { create(:user) }

  scenario 'Non-registered user tries to registrate' do
    visit root_path
    click_on 'Ask question'
    click_on 'Sign up'
    fill_in 'Email', with: 'newuser@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully'
    expect(page).to have_content 'Sign out'
  end

  scenario 'Authenticated user tries to registrate' do
    sign_in(user)

    visit root_path
    click_on 'Ask question'

    expect(page).to have_no_content 'Sign up'
  end
end
