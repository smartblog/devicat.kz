require_relative 'acceptance_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to ba able to ask questions
} do

  given(:user) { create(:user) }

  scenario 'Authentificates user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'text text'
  end

  scenario 'Authentificates user creates question with blank fields' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    click_on 'Create'

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-authentificated user tryes to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
