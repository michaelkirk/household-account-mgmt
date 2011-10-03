Feature: authentication
  In order to protect our user's information
  As a concerned privacy advocate
  I want to force user's to log in before doing anything

  Background:
    Given a user with email "worker@foodlobby.org" and password "super-secret"

  Scenario: logging in
    Given I am not logged in
    And I am on the sign in page
    When I fill in "worker@foodlobby.org" for "Email"
    And I fill in "super-secret" for "Password"
    And I press "Sign in"
    Then I should see "Listing households"

  Scenario: view page when logged in
    Given I am logged in
    When I go to the list of households
    Then I should see "Listing households"

  Scenario: failed log in
    Given I am not logged in
    And I am on the sign in page
    When I fill in "worker@foodlobby.org" for "Email"
    And I fill in "wrong password" for "Password"
    And I press "Sign in"
    Then I should see "Invalid email or password"
    And I should see "Sign in"

  Scenario: redirect to login
    Given I am not logged in
    When I go to the list of households
    Then I should see "Sign in"
    And I should see "Email"
    And I should see "Password"
    But I should not see "Listing households"

  Scenario: redirect back after login
    Given I am not logged in
    And I go to the list of all transactions
    Then I should not see "Listing transactions"
    But I should see "Sign in"
    When I fill in "worker@foodlobby.org" for "Email"
    And I fill in "super-secret" for "Password"
    And I press "Sign in"
    Then I should see "All transactions"
    But I should not see "Listing households"

