require_relative 'acceptance_helper'

feature 'Choose best answer', %q{
  On the question page
  as an authenticated user
  I need to be able to choose the best answer
} do

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:question) { create(:question_with_answers, user: user) }

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'Author see link Best' do
      within "#answer-#{question.answers.first.id}" do
        expect(page).to have_link 'Choose best'
      end
    end

    scenario 'Author try choose the best answer', js: true do
      within "#answer-#{question.answers.first.id}" do
        click_on 'Choose best'
        expect(page).to have_content 'Best answer'
      end
    end
  end

  scenario 'Another user does not see Best link' do
    sign_in(another_user)
    visit question_path(question)

    expect(page).to_not have_link 'Choose best'
  end

  scenario 'Non-authenticated user does not see Best link' do
    visit question_path(question)

    expect(page).to_not have_link 'Choose best'
  end
end
