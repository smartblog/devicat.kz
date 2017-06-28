require 'rails_helper'

RSpec.describe User do
  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let(:user) { create(:user) }
  let(:question) { create :question }
  let(:author) { question.user }

  describe '#author?' do
    it 'should return true if user is author of question' do
      expect(author).to be_author(question)
    end

    it 'should return false so as user is not author of question' do
      expect(user).to_not be_author(question)
    end
  end
end
