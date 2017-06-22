require 'rails_helper'

feature 'View question', %q{
  To find the required answer,
  user need view question
  and answers to that question
} do

  scenario 'Authenticated user view the question and their answers'
  scenario 'Unauthenticated user view the question and their answers'
end
