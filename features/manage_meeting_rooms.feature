Feature: Manage Meeting Rooms
  In order to create meeting rooms
  As an Admin
  I want to create and delete meeting rooms

  Scenario: Destroy Meeting Room
    Given the following meeting_room exist
      | id       | 2    |
      | name     | Test |
      | capacity | 100  |
    When I send a DELETE request to "/v1/meeting_rooms/" with id
      | id       | 2    |
    Then the response status should return "204"
    And the following meeting_room should not exist
      | name     | Test |
      | capacity | 100  |

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
