Feature: Monthly purchase and investment summary

  In order to track the health of the coop  
  As a worker
  I want to see statistics by month

  Background:
    Given I am logged in

  Scenario: two months of business
    Given there was a "$50" purchase on "January 1, 2011"
    And there was a "$40" purchase on "January 31, 2011"
    And there was a "$60" investment on "January 15, 2011"
    And there was a "$50" purchase on "February 1, 2011"
    And there was a "$40" investment on "February 27, 2011"
    And there was a "$60" investment on "February 12, 2011"

    And I am on the monthly reports page

    Then I should see "$90"
    And I should see "$60"
    And I should see "$50"
    And I should see "$100"
