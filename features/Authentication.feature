Feature: Authentication
  In order to manage my todo tasks
  As a busy fellow
  I want to login first

  Background:
    Given I am not logged in
    And I have a user "test" with password "secret"

  Scenario: Visiting the page
    When I visit the page
    Then I should see the login form

  Scenario Outline: Unsuccesful authentication
    When I log in with <username> and <password>
    Then I should see <message>

    Examples:
      | username | password |        message         |  
      | "random" |    ""    | "Password is required" |  
      |    ""    | "random" | "Username is required" |  
      | "random" | "random" |   "Invalid username"   |  
      |  "test"  | "random" |   "Invalid password"   |  

  Scenario: Succesfull authentication
    When I log in with "test" and "secret"
    Then I should see the tasks page for user "test"

  Scenario: Authentication persistance
    Given I am logged in with "test" and "secret"
    When I visit the page
    Then I should see the tasks page for user "test"

  Scenario Outline: Unsuccesful registering
    When I register with <username> and <password>
    Then I should see <message>
    And I cannot log in with <username> and <password>

    Examples:
      | username | password |        message         |  
      | "random" |    ""    | "Password is required" |  
      |    ""    | "random" | "Username is required" |  
      |  "test"  | "random" |  "Username is taken"   |  

  Scenario: Succesful registering
    When I register with "username" and "password"
    Then I should see the tasks page for user "username"

  # Scenario: Succesful registration comeback
  #   When I register with "username" and "password"
  #   And I visit the page
  #   Then I should see the tasks page for user "username"
    
  Scenario: Succesful registration logout and comeback
    When I register with "username" and "password"
    And I log in with "username" and "password"
    Then I should see the tasks page for user "username"