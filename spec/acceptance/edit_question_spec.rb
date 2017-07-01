require_relative 'acceptance_helper'

feature 'Question editing', %q{
  In order to fix mistake
  as an author of question
  I'd like to be able to edit question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Unuthenticated user try edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'see question edit link' do
      expect(page).to have_link 'Edit question'
    end

    scenario 'tries to edit his question', js: true do
      click_on 'Edit question'
      fill_in 'question_title', with: 'new question title'
      fill_in 'question body', with: 'new question body'
      click_on 'Save question'

      expect(page).to_not have_content question.body
      expect(page).to have_content 'new question title'
      expect(page).to_not have_content question.title
      expect(page).to have_content 'new question title'
    end

    let(:another_user) { create(:user) }
    scenario "try to edit not his questions", js: true do
      click_on 'Sign out'
      sign_in(another_user)
      visit question_path(question)

      expect(page).to_not have_link 'Edit'
    end
  end
end
