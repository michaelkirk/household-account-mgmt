Feature: Void transaction when error

  As bulkroom worker 
  So as to allow for mistakes 
  Without corrupting sales reports
  I want to void erroneous transactions

  Background:
    Given I am logged in
    Given a household with a $50 balance
    And I deposit $30 into the household's account
    When I edit the last transaction
    And I check "Void transaction" 
    And I press "update"
    Then I should see "Household transaction was successfully updated"

  Scenario: Erroneous transaction
    When I view that household
    Then I should see "Balance: $50"

  Scenario: Resaving a voided transaction
    When I edit the last transaction
    And I press "update"
    And I view that household
    Then I should see "Balance: $50"

  Scenario: Unvoiding a transaction
    When I edit the last transaction
    And I uncheck "Void transaction"
    And I press "update"
    Then I should see "Household transaction was successfully updated"
    And I view that household
    And I should see "Balance: $80"



