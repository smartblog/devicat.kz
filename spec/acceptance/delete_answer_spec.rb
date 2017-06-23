require 'rails_helper'

feature 'User delete his answers', %q{
  User can delete his answers
  but can't delete not his answers
} do

  given(:user) { create(:user) }
  given(:user_with_answers) { create(:user_with_answers) }
  given(:answer) { create(:answer) }

  scenario 'User try delete his answer' do
    sign_in(user_with_answers)

    visit question_path(user_with_answers.answers.first.question)
    click_on 'Delete answer'

    expect(page).to have_content 'Your answer successfully destroy'
    expect(page).to have_no_content answer.body
  end

  scenario 'User try delete not his answer' do
    sign_in(user)

    visit question_path(user_with_answers.answers.first.question)
    expect(page).to have_no_content 'Delete answer'
  end
end
