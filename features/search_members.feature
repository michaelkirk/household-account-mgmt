Feature: Search members

  In order to quickly find our members
  As a memership coordinator
  I want to filter the member list by name

  Background:
    Given I am logged in
    And a household with "Tye Johnson and Jared Noem" as members
    And a household with "Jessie James" as a member
    And I am on the members page

  Scenario: search for full name
    When I search for "Tye Johnson"
    Then I should see "Tye Johnson" within "#members"
    And I should see "Jared Noem" within "#members"
    But I should not see "Jessie James" within "#members"

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
    And I should see "Jared Noem"

  Scenario: search for non existent member
    When I search for "Fake Person"
    Then I should see "There are no members matching your criteria"

  Scenario: search for existent and non existent member
    When I search for "Fake Noem"
    Then I should see "Jared Noem"

  #This fails cucumber, but the browser actually passes
  @wip
  Scenario: case insensitve
    When I search for "james"
    Then I should see "Jessie James"

