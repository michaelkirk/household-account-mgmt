Feature: Household balance

  In order to know if a member needs to make an investment
  As a bulkroom worker
  I want to see the member's household's balance

  Background: Logged in
    Given I am logged in

  Scenario: View a household balance
    Given a household with a $50 balance
    When I view that household
    Then I should see "Balance: $50.00"
