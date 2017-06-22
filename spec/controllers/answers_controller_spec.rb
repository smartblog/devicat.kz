require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }

  describe 'POST #create' do
    sign_in_user
    before { question }

    context 'with valid params' do
      it 'save new answer in database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(@user.answers, :count).by(1)
      end
      it 'associates answer with the question' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end
      it 'redirect to show of question view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(assigns(:answer).question)
      end
    end

    context 'with invalid params' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) } }.to_not change(@user.answers, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }
        expect(response).to render_template('questions/show')
      end
    end
  end
end
