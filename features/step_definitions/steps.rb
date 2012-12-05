def logout
end

When /^I do nothing$/ do
end

Given /^I am not logged in$/ do
  logout
end

When /^I visit the page$/ do
  visit "/"
end

Then /^I should see the login form$/ do
  page.should have_selector "#login-form"
end

Given /^I am on the login form$/ do
  logout
  visit "/"
end

When /^I try to login with random info$/ do
  fill_in "username", :with => "random"
  fill_in "password", :with => "random"
end

Then /^I don't get in$/ do
  page.should have_content "Invalid user data"
end
