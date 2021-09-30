Feature: Manage Meeting Rooms
  In order to create meeting rooms
  As an Admin
  I want to create and delete meeting rooms

  Scenario: Destroy Meeting Room
    When I send a DELETE request to "/v1/meeting_rooms/" with id
    Then the response status should be "204"
    And the same meeting_room can not find

  Scenario: A user can create a Meeting room by sending a POST request with all required parameters
    When I send a POST request to "/v1/meeting_rooms" with the following:
      | name | gyan |
      | capacity   | 100 |
    Then the following json response is sent:
    """
    {

      "id": 1,
      "name": "gyan",
      "capacity": "100"
    }
    """
    And the response status should be "201"

  Scenario: A user can not create a Meeting room by sending a POST request Without Name
    When I send a POST request to "/v1/meeting_rooms" with the following:
      | capacity   | '100' |
    Then the following json response is sent:
    """
    {"name":["can't be blank"]}
    """
    And the response status should be "422"

  Scenario: A user can not create a Meeting room by sending a POST request Without Capacity
    When I send a POST request to "/v1/meeting_rooms" with the following:
      | name | gyan |
    Then the following json response is sent:
    """
    {"capacity":["can't be blank"]}
    """
    And the response status should be "422"
