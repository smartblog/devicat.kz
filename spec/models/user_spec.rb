require 'rails_helper'

RSpec.describe User do
  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let(:user) { create(:user) }
  let(:user_with_questions) { create(:user_with_questions) }
  let(:user_with_answers) { create(:user_with_answers) }

  describe 'check author? for questions' do
    it 'should return true if user is author of question' do
      expect(user_with_questions).to be_author(user_with_questions.questions.first)
    end

    it '#author_of should return false so as user is not author of question' do
      expect(user).to_not be_author(user_with_questions.questions.first)
    end
  end

  describe 'check author? for answers' do
    it 'should return true if user is author of answer' do
      expect(user_with_answers).to be_author(user_with_answers.answers.first)
    end

    it '#author_of should return false so as user is not author of answer' do
      expect(user).to_not be_author(user_with_answers.answers.first)
    end
  end
end
