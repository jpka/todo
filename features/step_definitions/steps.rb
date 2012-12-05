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

When /^I try to login with "(.*?)" and "(.*?)"$/ do |username, password|
  fill_in "username", :with => username
  fill_in "password", :with => password
  click_button "login-button"
end

Then /^I see "(.*?)"$/ do |message|
  page.should have_content message
end
