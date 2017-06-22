require 'rails_helper'

feature 'List of Questions', %q{
  To find the required answer,
  user should view list of questions
} do
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 2) }

  scenario 'Authenticated user views list of questions' do
    sign_in(user)

    visit questions_path
    expect(page).to have_content questions.first.title
    expect(page).to have_content questions.last.title
  end

  scenario 'Unauthenticated user views list of question' do
    visit questions_path

    expect(page).to have_content questions.first.title
    expect(page).to have_content questions.last.title
  end
end
