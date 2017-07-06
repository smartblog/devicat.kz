require_relative 'acceptance_helper.rb'

feature 'Vote for answer', %q{
  In order to rate answer
  Authenticated user
  can vote for answer
} do
  scenario 'authenticated user vote for answer'
  scenario 'author try vote for his answer'
  scenario 'non-authenticated user try to vote for answer'
end
