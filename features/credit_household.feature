Feature: Credit a household

  In order to maintain a balance for future purchases
  As a bulk room worker
  I want to add credit to members balances

  Background:
    Given I am logged in

  Scenario: Credit a household
    Given a household with a $50 balance
    And I view that household
    When I choose "Credit"
    And I fill in "30.50" for "Amount"
    And I press "Create Transaction"
    Then I should see "Household transaction was successfully created"
    And I should see "Balance: $80.50"

  Scenario: Submit empty form
    Given a household with a $50 balance
    And I view that household
    When I press "Create Transaction"
    Then I should see "Error creating transaction"
    And I should see "Balance: $50"

