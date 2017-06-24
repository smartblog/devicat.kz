FactoryGirl.define do

  factory :answer do
    sequence(:body) { |n| "AnswerText#{n}" }
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
  end
end
