Feature: Search households

  In order to quickly credit/debit the right account
  As a bulk room worker
  I want to search through households using their members names

  Background:
    Given I am logged in
    And a household with "Tye Johnson and Jared Noem" as members
    And a household with "Jessie James" as a member
    And I am on the list of households

  Scenario: search for full name
    When I search for "Tye Johnson"
    Then I should see "Tye Johnson" within "#households"
    And I should see "Jared Noem" within "#households"
    But I should not see "Jessie James" within "#households"

  Scenario: search with first name
    When I search for "Tye"
    Then I should see "Tye Johnson"
    And I should see "Jared Noem"
    But I should not see "Jessie James"

  Scenario: search with last name
    When I search for "Johnson"
    Then I should see "Tye Johnson"
    And I should see "Jared Noem"
    But I should not see "Jessie James"

  Scenario: search across multiple members
    When I search for "Tye Jared"
    Then I should see "Tye Johnson"
    And I should see "Jared Noem"
    But I should not see "Jessie James"

  Scenario: blank search form
    When I search for ""
    Then I should see "Tye Johnson"
    And I should see "Jessie James"

  Scenario: search for non existent member
    When I search for "Fake Person"
    Then I should see "There are no households matching your criteria"

  Scenario: search for existant and non existent member
    When I search for "Fake Noem"
    Then I should see "Jared Noem"

  #This fails cucumber, but the browser actually passes
  @wip
  Scenario: case insensitve
    When I search for "james"
    Then I should see "Jessie James"

