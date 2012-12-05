Feature: Authentication
  In order to manage my todo tasks
  As a busy fellow
  I want to login first

  Background:
    Given I am not logged in

  Scenario: Visiting the page
    When I visit the page
    Then I should see the login form

  Scenario Outline: Filling the form
    Given I am on the login form
    When I try to login with <username> and <password>
    Then I see <message>

    Examples:
      | username | password |           message           |
      | "random" |    ""    | "Password cannot be empty"  |
      |    ""    | "random" | "Username cannot be empty"  |
      | "random" | "random" | "Invalid username/password" |

  # Scenario: Reading when online
  #   When I search for "Ulysses"
  #   And I select the first book
  #   And I wait
  #   Then I should get to read it

  # Background: Offline
  #   Given I am offline
  # Scenario Outline: Reading while offline
  #   Given I am offline
  #   When I search for <book>
  #   And I select the first book
  #   Then I <should> get to read it

  # Examples:
  #   | book              | should    |
  #   | 'Leaves of grass' | shouldn't |
  #   | 'Ulysses'         | should    |
