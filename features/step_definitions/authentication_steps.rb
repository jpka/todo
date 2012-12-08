Then /^I should see the login form$/ do
  page.should have_selector "#login-form"
end

Given /^I am on the login form$/ do
  logout
  visit "/"
end

When /^I log in with "(.*?)" and "(.*?)"$/ do |username, password|
  logout
  visit "/"
  fill_in "username", :with => username
  fill_in "password", :with => password
  click_button "login-button"
end

When /^I register with "(.*?)" and "(.*?)"$/ do |username, password|
  logout
  visit "/"
  fill_in "username", :with => username
  fill_in "password", :with => password
  click_button "register-button"
end

Then /^I cannot log in with "(.*?)" and "(.*?)"$/ do |username, password|
  logout
  visit "/"
  fill_in "username", :with => username
  fill_in "password", :with => password
  click_button "login-button"
  page.should_not have_content "#{username}'s tasks"
end

Then /^I should see the tasks page for user "(.*?)"$/ do |user|
  page.should have_content "#{user}'s tasks"
end

Given /^I am logged in with "(.*?)" and "(.*?)"$/ do |username, password|
  page.driver.set_cookie("username", "test")
  page.driver.set_cookie("password", "secret")
end

Given /^I am not logged in$/ do
  logout
end