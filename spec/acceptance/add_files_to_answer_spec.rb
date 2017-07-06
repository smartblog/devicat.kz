require_relative 'acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answer's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
    fill_in 'answer_body', with: 'My answer'
    click_on 'add file'
    uploads = all('input[type="file"]')
    uploads[0].set("#{Rails.root}/spec/spec_helper.rb")
    uploads[1].set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Create'
  end

  scenario 'User adds files to answer', js: true do
    within ".answers" do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    end
  end
end
