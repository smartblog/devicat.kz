require_relative 'acceptance_helper.rb'

feature 'Revote for question', %q{
  Authenticated user
  Id like to be able to revote for question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:another_user) { create(:user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'authenticated user revote for answer', js: true do
    within '.question' do
      choose 'Like'
      click_on 'Vote'
      click_on 'Revote'
      within "#rate-question-#{question.id}" do
        expect(page).to have_content "0"
      end
      expect(page).to have_button 'Vote'
    end
  end

  scenario 'another user try to revote for question', js: true do
    click_on 'Sign out'
    sign_in(another_user)
    visit question_path(question)
    within '.question' do
      expect(page).to have_no_button 'Revote'
    end
  end
  scenario 'Non-authenticated user try revote for question', js: true do
    click_on 'Sign out'
    visit question_path(question)
    within '.question' do
      expect(page).to have_no_button 'Revote'
    end
  end
end
