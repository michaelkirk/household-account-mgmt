Feature: Transactions

  In order to follow good accounting principles
  As an accountant
  I want our credits and debits to add up.

Scenario: Initial balance
  Given a new Household
  When I look at the household's balance
  Then I should see $0


