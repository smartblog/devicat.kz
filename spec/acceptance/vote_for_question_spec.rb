require_relative 'acceptance_helper.rb'

feature 'Vote for question', %q{
  In order to rate question
  As an authenticated user
  Id like to be able to vote for question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:users_question) { create(:question, user: user) }

  scenario 'authenticated user like question', js: true do
    sign_in(user)
    visit question_path(question)
    within '.question' do
      choose 'Like'
      click_on 'Vote'
      within "#rate-question-#{question.id}" do
        expect(page).to have_content "1"
      end
      expect(page).to have_content "You like it"
      expect(page).to have_button 'Revote'
    end
  end

  scenario 'authenticated user dislike question', js: true do
    sign_in(user)
    visit question_path(question)
    within '.question' do
      choose 'Dislike'
      click_on 'Vote'
      within "#rate-question-#{question.id}" do
        expect(page).to have_content "-1"
      end
      expect(page).to have_content "You dislike it"
      expect(page).to have_button 'Revote'
    end
  end

  scenario 'authenticated user try vote for question once more time', js: true do
    sign_in(user)
    visit question_path(question)
    within '.question' do
      choose 'Like'
      click_on 'Vote'
      expect(page).to have_no_button 'Vote'
    end
  end

  scenario 'author try vote for his question' do
    sign_in(user)
    visit question_path(users_question)
    within '.question' do
      expect(page).to have_no_button 'Vote'
    end
  end

  scenario 'non-authenticated user try to vote for question' do
    visit question_path(question)
    within '.question' do
      expect(page).to have_no_button 'Vote'
    end
  end
end
