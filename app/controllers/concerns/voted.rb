module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: :vote
  end

  def vote
    respond_to do |format|
      if current_user.author?(@votable)
        format.json { render json:
          { votable: @votable,
            resource: controller_name.singularize ,
            error: "You can't vote for your #{controller_name.singularize}" },
            status: 403 }
      else
        actions = %w{ like dislike cancel_vote}
        @votable.send(params[:vote], current_user) if actions.include?(params[:vote])
        @vote = @votable.votes.where(user: current_user).first
        format.json { render json: { resource: controller_name.singularize ,
                                     votable: @votable,
                                     vote: @vote,
                                     vote_value: @vote&.show_value } }
      end
    end
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end
end
