require 'rails_helper'

feature 'User delete his questions', %q{
  User can delete his questions
  but can't delete not his questions
} do

  given(:user) { create(:user) }
  given(:user_with_questions) { create(:user_with_questions) }

  scenario 'User try delete his question' do
    sign_in(user_with_questions)
    @temp_title = user_with_questions.questions.first.title
    visit question_path(user_with_questions.questions.first)
    click_on 'Delete question'

    expect(page).to have_content 'Your question successfully destroy'
    expect(page).to have_no_content @temp_title
  end

  scenario 'User try delete not his question' do
    sign_in(user)

    visit question_path(user_with_questions.questions.first)
    expect(page).to have_no_content 'Delete question'
  end

  scenario 'Non-authentificated user try delete question' do
    visit question_path(user_with_questions.questions.first)
    expect(page).to have_no_content 'Delete question'
  end
end
