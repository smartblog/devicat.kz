require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'validates presence of title' do
    expect(Question.new(body: 'Test text')).to_not be_valid
  end

  it 'validates presence of body' do
    expect(Question.new(title: 'Title test')).to_not be_valid
  end
end
