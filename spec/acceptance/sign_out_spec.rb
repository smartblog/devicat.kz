require 'rails_helper'

feature 'User sign out', %q{
  To finish session
  user need to sign out
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user try to sign out' do
    sign_in(user)
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully'
    expect(page).to have_content 'Sign in'
  end

  scenario 'Unauthenticated user try to sign out'
end
