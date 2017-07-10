class Vote < ApplicationRecord
  belongs_to :votable, optional: true, polymorphic: true
  belongs_to :user

  def show_value
    { 1 => :like, -1 => :dislike }[value]
  end
end
