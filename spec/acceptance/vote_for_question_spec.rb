require_relative 'acceptance_helper.rb'

feature 'Vote for question', %q{
  In order to rate question
  Authenticated user
  can vote for question
} do
  scenario 'authenticated user vote for question'
  scenario 'authenticated user try to vote for question once more time'
  scenario 'author try to vote for his question'
  scenario 'non-authenticated user try vote for question'
end
