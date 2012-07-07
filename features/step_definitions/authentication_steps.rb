Given /^I am logged in$/ do
  step "I am not logged in"
  step 'a user with email "somebody@foodlobby.org" and password "secret"'
  step "I am on the sign in page"
  step 'I fill in "somebody@foodlobby.org" for "Email"'
  step 'I fill in "secret" for "Password"'
  step 'I press "Sign in"'
end

Given /^I am not logged in$/ do
  #not logged in by default, so do nothing
end

Given /^a user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  User.create!(:email => email, :password => password)
end
