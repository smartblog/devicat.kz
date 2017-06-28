require 'rails_helper'

feature 'Create answer', %q{
  To answer to question
  on the question page
  authenticated user create answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user answers the question' do
    sign_in(user)
    visit question_path(question)
    fill_in 'answer_body', with: 'Answer text'
    click_on 'Create answer'

    expect(page).to have_content 'Answer text'
    expect(page).to have_content 'Answer was successfully created'
  end

  scenario 'Authenticated user answers the question blank body' do
    sign_in(user)
    visit question_path(question)
    click_on 'Create answer'

    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-Authenticated user answers the question' do
    visit question_path(question)

    expect(page).to have_no_content 'Create answer'
  end
end
