require_relative 'acceptance_helper.rb'

feature 'Revote for answer', %q{
  Authenticated user
  Id like to be able to revote for answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }
  given!(:another_user) { create(:user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'authenticated user revote for answer', js: true do
    within '.answers' do
      choose 'Like'
      click_on 'Vote'
      click_on 'Revote'
      within "#rate-answer-#{answer.id}" do
        expect(page).to have_content "0"
      end
      expect(page).to have_button 'Vote'
    end
  end
  scenario 'another user try cancel vote for answer', js: true do
    click_on 'Sign out'
    sign_in(another_user)
    visit question_path(question)
    within '.answers' do
      expect(page).to have_no_button 'Revote'
    end
  end

  scenario 'Non-authenticated user try cancel vote for answer', js: true do
    click_on 'Sign out'
    visit question_path(question)
    within '.answers' do
      expect(page).to have_no_button 'Revote'
    end
  end
end
