Feature: Weekly Throughput

  In order to gauge the productivity of the coop
  As a user
  I want to see how much was purchased

  Background:
    Given I am logged in
    And a household with a $50 balance

  Scenario: No sales yet
    And I am on the homepage
    Then I should see "We've spent $0 on yummy food this week =("

  Scenario: One Sale
    Given that household spends $20
    When I am on the homepage
    Then I should see "We've spent $20 on yummy food this week"

  Scenario: Don't count sales from last week
    Given that household spent $20 over a week ago
    When I am on the homepage
    Then I should see "We've spent $0 on yummy food this week"
