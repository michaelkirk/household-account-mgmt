Feature: Search households

  In order to quickly credit/debit the right account
  As a bulk room worker
  I want to search through households using their members names

  Background:
    Given I am logged in
    And a household with "Tye Johnson and Jared Noem" as members
    And a household with "Jessie James" as a member
    And I am on the list of households

  Scenario: search with first name
    When I search for "Tye"
    Then I should see "Tye Johnson"
    And I should see "Jared Noem"
    But I should not see "Jessie James"

  Scenario: blank search form
    When I search for ""
    Then I should see "Tye Johnson"
    And I should see "Jessie James"

  Scenario: search for non existent member
    When I search for "Fake Person"
    Then I should see "There are no active households matching your criteria"

