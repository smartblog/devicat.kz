require_relative 'acceptance_helper.rb'

feature 'Delete file from question', %q{
  As an questions author
  Id like to be able to delete attached file
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:file) { File.open("#{Rails.root}/spec/spec_helper.rb") }
  given(:another_question) { create(:question) }

  describe 'User try delete file from question', js: true do
    background do
      sign_in(user)
      question.attachments.create(file: file)
    end

    scenario 'Author deletes file from question' do
      visit question_path(question)

      within '.question-attachments' do
        click_on 'delete file'
        expect(page).to have_no_link 'spec_helper.rb'
      end
    end

    scenario 'User try delete file from not his question' do
      visit question_path(another_question)
      within '.question' do
        expect(page).to have_no_link 'delete file'
      end
    end
  end
end
