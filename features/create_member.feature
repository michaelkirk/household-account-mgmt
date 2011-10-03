Feature: Create a member

  In order to add new members to the coop
  As a bulk room worker
  I want to create new members

  Background:
    Given I am logged in

  Scenario: create a member
    Given I am on the add member form
    When I fill in "Tye" for "First name"
    And I fill in "Johnson" for "Last name"
    And I select "Put this member in a new household" from "Household"
    And I press "Create Member"
    Then I should see "Member was successfully created"
    And I should see "Tye Johnson"
    And I should not see any members besides "Tye Johnson"

  Scenario: add member to household
    Given a household with "Jared Noem" as a member
    And I am on the add member form
    When I fill in "Tye" for "First name"
    And I fill in "Johnson" for "Last name"
    And I select "Jared Noem" from "Household"
    And I press "Create Member"
    Then I should see "Member was successfully created"
    And I should not see any members besides "Jared Noem and Tye Johnson"

  Scenario: browse to creation form
    Given I am on the homepage
    When I follow "members"
    And I follow "New Member"
    Then I should see "New member"
    And I should see "First name"
    And I should see "Last name"