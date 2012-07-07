Feature: Search members

  In order to quickly find our members
  As a memership coordinator
  I want to filter the member list by name

  Background:
    Given I am logged in
    And "Tye Johnson" is an active member
    And "Jared Noem" is an active member
    And "Jessie James" is an inactive member
    And I am on the members page

  Scenario: search with first name
    When I search for "Tye"
    Then I should see "Tye Johnson"
    But I should not see "Jessie James"
    And I should not see "Jared Noem"

  Scenario: blank search form
    When I search for ""
    Then I should see "Tye Johnson"
    And I should see "Jessie James"
    And I should see "Jared Noem"

  Scenario: search for non existent member
    When I search for "Fake Person"
    Then I should see "There are no members matching your criteria"

  Scenario: Filtering by active
    When I select "active"
    And I search for ""
    Then I should see "Jared Noem"
    Then I should see "Tye Johnson"
    But I should not see "Jessie James"

  Scenario: filtering by inactive and name
    When I select "active"
    And I search for "Tye"
    Then  I should see "Tye Johnson"
    But I should not see "Jared Noem"
    And I should not see "Jessie James"

