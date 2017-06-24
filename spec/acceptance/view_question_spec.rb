require 'rails_helper'

feature 'View question', %q{
  To find the required answer,
  user need view question
  and answers to that question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question_with_answers) }

  scenario 'Authenticated user view the question and their answers' do
    sign_in(user)
    visit_and_view_question
  end

  scenario 'Unauthenticated user view the question and their answers' do
    visit_and_view_question
  end

  private

  def visit_and_view_question
    visit question_path(question)

    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
    question.answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end
