require 'rails_helper'

feature 'User delete his questions', %q{
  User can delete his questions
  but can't delete not his questions
} do

  scenario 'User try delete his question' do
    sign_in(user)

    visit question_path(user.questions.first)
    click_on 'Delete question'

    expect(page).to have_content 'Your question successfully deleted'
  end

  scenario 'User try delete not his question' do
    sign_in(user)

    visit question_path(user2.questions.first)
    
    expect(page).to have_no_content 'Delete question'
  end
end
