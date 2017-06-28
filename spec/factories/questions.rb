FactoryGirl.define do

  factory :question do
    sequence(:title) { |n| "MyString#{n}" }
    body 'MyText'
    user

    factory :question_with_answers do
      transient do
        answers_count 3
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answers_count, question: question)
      end
    end
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
