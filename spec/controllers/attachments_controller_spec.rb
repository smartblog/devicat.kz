require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  describe 'DELETE #destroy' do
    sign_in_user
    let(:question) { create(:question, user: @user) }
    let(:another_question) { create(:question) }

    before do
      file = File.open("#{Rails.root}/spec/spec_helper.rb")
      question.attachments.create(file: file)
      another_question.attachments.create(file: file)
    end

    context 'user try delete file from his question' do
      it 'deletes file' do
        expect { delete :destroy, params: { id: question.attachments.last } }.to change(Attachment, :count).by(-1)
      end
    end

    context 'user try to delete file from not his question' do
      it 'does not deletes file' do
        expect { delete :destroy, params: { id: another_question.attachments.last } }.to_not change(Attachment, :count)
      end
    end
  end
end
