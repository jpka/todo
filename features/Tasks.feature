Feature: Task listing
  In order to keep track of my tasks
  As a busy fellow
  I want to see them listed
  
  Scenario: Visiting the page
    Given I am not logged in
    When I visit the page
    Then I should see the login form

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
