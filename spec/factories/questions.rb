FactoryGirl.define do
  sequence :title do |n|
    "MyString#{n}"
  end

  factory :question do
    title
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
