require 'rails_helper'

feature 'Create answer', %q{
  To answer to question
  on the question page
  authenticated user create answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user answers the question', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'answer_body', with: 'My answer'
    click_on 'Create answer'

    expect(page).to have_content 'My answer'
  end

  scenario 'Non-Authenticated user answers the question' do
    visit question_path(question)

    expect(page).to have_no_content 'Create answer'
  end
end
