When /^I do nothing$/ do
end

Given /^I am not logged in$/ do
end

When /^I visit the page$/ do
  visit "/"
end

Then /^I should see the login form$/ do
  page.should have_selector "form#login"
end
