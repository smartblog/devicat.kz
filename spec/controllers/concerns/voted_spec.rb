require 'rails_helper'

shared_examples_for 'voted' do

  describe 'PATCH #set_vote' do
    sign_in_user
    let(:resource) { controller.controller_name.singularize.to_sym }
    let(:votable) { create(resource) }
    let(:users_votable) { create(resource, user: @user) }

    context 'user try to like resource' do
      it 'set like to resource' do
        expect { patch :vote, params: { id: votable, vote: :like }, format: :json }.to change(Vote, :count).by(1)
      end

      it 'increases rating by 1' do
        patch :vote, params: { id: votable, vote: :like }, format: :json
        votable.reload
        expect(votable.rating).to eq 1
      end
    end

    context 'user try dislike resource' do
      it 'set like to resource' do
        expect { patch :vote, params: { id: votable, vote: :dislike }, format: :json }.to change(Vote, :count).by(1)
      end

      it 'decreases rating by 1' do
        patch :vote, params: { id: votable, vote: :dislike }, format: :json
        votable.reload
        expect(votable.rating).to eq -1
      end
    end
  end
end
