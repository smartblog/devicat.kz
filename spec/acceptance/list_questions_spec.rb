require 'rails_helper'

feature 'List of Questions', %q{
  To find the required answer,
  user should view list of questions
} do
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 2) }

  scenario 'Authenticated user views list of questions' do
    sign_in(user)
    visit_and_check_questions
  end

  scenario 'Unauthenticated user views list of question' do
    visit_and_check_questions
  end

  private

  def visit_and_check_questions
    visit questions_path

    questions.each do |question|
      expect(page).to have_content question.title
    end
  end
end
