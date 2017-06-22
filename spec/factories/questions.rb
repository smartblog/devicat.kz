FactoryGirl.define do
  sequence :title do |n|
    "MyString#{n}"
  end

  factory :question do
    title
    body 'MyText'
  end

  factory :question_with_answers, class: "Question" do
    title 'MyString'
    body 'MyText'

    after(:create) do
      create_list(:answer, 3)
    end
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
