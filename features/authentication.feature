Feature: authentication
  In order to protect our user's information
  As a concerned privacy advocate
  I want to force user's to log in before doing anything

  @wip
  Scenario: redirect to login
    Given I am not logged in
    When I go to households_path
    Then I should see "Login Required"
    And I should see "username"
    Then I should see "password"
    And I should not see "Household details"


  @ignore
  Scenario: view household
    Given I am logged in
    When I go to households_path
    Then I should see "Households"
    And I should not see "Login Required"

