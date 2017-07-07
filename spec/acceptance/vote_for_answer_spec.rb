require_relative 'acceptance_helper.rb'

feature 'Vote for answer', %q{
  In order to rate answer
  Authenticated user
  can vote for answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'authenticated user like answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      choose 'Like'
      click_on 'Vote'
    end
  end

  scenario 'authenticated user dislike answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      choose 'Dislike'
      click_on 'Vote'
    end
  end

  scenario 'authenticated user try vote answer once more time', js: true do
    sign_in(user)
    visit question_path(question)
    within '.answers' do
      choose 'Like'
      click_on 'Vote'
      expect(page).to have_no_button 'Vote'
    end
  end

  scenario 'author try vote for his answer' do
    sign_in(answer.user)
    visit question_path(question)
    within '.answers' do
      expect(page).to have_no_button 'Vote'
    end
  end

  scenario 'non-authenticated user try vote for answer' do
    visit question_path(question)
    within '.answers' do
      expect(page).to have_no_button 'Vote'
    end
  end
end
