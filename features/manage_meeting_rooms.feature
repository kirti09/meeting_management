Feature: Manage Meeting Rooms
  In order to create meeting rooms 
  As an Admin
  I want to create and delete meeting rooms

  Scenario: Create Meeting Room
    Given A POST request is made
    When admin create a meeting room
    And I fill in 'name' with 'Gyan'
    And I fill in 'capacity' with '50'
    Then I should see status '201'
    And I should see 'Gyan'
    And I should have 1 meeting room

