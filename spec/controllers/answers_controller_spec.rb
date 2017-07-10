require 'rails_helper'
require_relative 'concerns/voted_spec.rb'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }

  describe 'POST #create' do
    sign_in_user
    before { question }

    context 'with valid params' do
      it 'save new answer in database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js } }.to change(@user.answers, :count).by(1)
      end
      it 'associates answer with the question' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js } }.to change(question.answers, :count).by(1)
      end
      it 'renders create template' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid params' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer), format: :js } }.to_not change(Answer, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:users_answer) { create(:answer, user: @user, question_id: question.id) }

    before { answer }

    context 'user try delete his answer' do
      it 'deletes answer' do
        expect { delete :destroy, params: { id: users_answer }, format: :js }.to change(Answer, :count).by(-1)
      end

      it 'renders question destroy view' do
        delete :destroy, params: { id: users_answer }, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'user try delete not his answer' do
      it 'does not deletes answer' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end

      it 'redirects to questions index view' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to questions_path
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    let!(:users_answer) { create(:answer, user: @user, question_id: question.id) }

    context 'author try update answer' do
      it 'assigns the requested answer to @answer' do
        patch :update, params: { question_id: question, id: users_answer, answer: attributes_for(:answer) }, format: :js
        expect(assigns(:answer)).to eq users_answer
      end

      it 'change answer attributes' do
        patch :update, params: { question_id: question, id: users_answer, answer: { body: 'new_body' } }, format: :js
        users_answer.reload
        expect(users_answer.body).to eq 'new_body'
      end

      it 'renders update template' do
        patch :update, params: { question_id: question, id: users_answer, answer: attributes_for(:answer) }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'another user try update not his answer' do
      before do
        patch :update, params: { question_id: question, id: answer, answer: { body: 'new_body' } }, format: :js
      end
      it 'does not change answer attributes' do
        answer_body = answer.body
        answer.reload

        expect(answer.body).to eq answer_body
      end
    end
  end

  describe 'PATCH #set_best' do
    sign_in_user

    context 'author of question try set best answer' do
      let!(:users_question) { create(:question_with_answers, user: @user) }
      it 'set best answer' do
        patch :set_best, params: { id: users_question.answers.first }, format: :js
        expect(assigns(:answer).best).to eq true
      end
    end

    context 'another user try set best answer' do
      let(:question) { create(:question_with_answers) }
      before do
        patch :set_best, params: { id: question.answers.first }, format: :js
      end

      it 'should not set best answer' do
        expect(assigns(:answer).best).to eq false
      end
    end

    context 'Non-authenticated user try set best answer' do
      let(:question) { create(:question_with_answers) }
      let(:answer) { question.answers.first }
      before do
        patch :set_best, params: { id: answer }, format: :js
      end

      it 'should not set best answer' do
        sign_out(@user)
        expect(answer.best).to eq false
      end
    end
  end

  it_behaves_like 'voted'
end
