FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    password '12345678'
    password_confirmation '12345678'

    factory :user_with_questions do
      transient do
        questions_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:question, evaluator.questions_count, user: user)
      end
    end

    factory :user_with_answers do
      transient do
        answers_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:answer, evaluator.answers_count, user: user)
      end
    end
  end
end
