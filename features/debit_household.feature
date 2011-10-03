Feature: Debit a household

  In order to charge a member for their purchase
  As a bulk room worker
  I want to be able to debit a member's household's account

  Background:
    Given I am logged in

  Scenario: Debit the household
    Given a household with a $50 balance
    And I view that household
    When I choose "Debit"
    And I fill in "20" for "Amount"
    And I press "Create Transaction"
    Then I should see "Household transaction was successfully created"
    And I should see "Balance: $30"

  