Feature: Transactions

  In order to follow good accounting principles
  As an accountant
  I want our credits and debits to add up.

Scenario: Initial balance
  Given a new Household
  When I look at the household's balance
  Then I should see $0

Scenario: Initial deposit
  Given a new Household
  When I deposit $50 into the household's account
  And I look at the household's balance
  Then I should see $50

