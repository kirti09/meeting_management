Feature: Manage Meeting Rooms
  In order to create meeting rooms
  As an Admin
  I want to create and delete meeting rooms

  Scenario: Destroy Meeting Room
    When I send a DELETE request to "/v1/meeting_rooms/" with id
    Then the response status should be "204"
    And the same meeting_room can not find
