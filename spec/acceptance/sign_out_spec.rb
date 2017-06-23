require 'rails_helper'

feature 'User sign out', %q{
  To finish session
  user need to sign out
} do
  scenario 'Authenticated user try to sign out'
  scenario 'Unauthenticated user try to sign out'
end
