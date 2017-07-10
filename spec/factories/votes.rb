FactoryGirl.define do
  factory :vote do
    is_liked false
  end

  factory :like_vote, class: "Vote" do
    value 1
    user
  end

  factory :dislike_vote, class: "Vote" do
    value -1
    user
  end

end
