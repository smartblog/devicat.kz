require 'rails_helper'

feature 'User delete his questions', %q{
  User can delete his questions
  but can't delete not his questions
} do

  scenario 'User try delete his question'
  scenario 'User try delete not his question'
end
