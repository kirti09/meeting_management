Feature: Manage Meeting Rooms
  In order to create meeting rooms 
  As an Admin
  I want to create and delete meeting rooms

  Scenario: Create Meeting Room
    When I send a POST request to "/v1/meeting_rooms" with the following:
      | name | gyan |
      | capacity   | '100' |
    Then the response status should be "201"

  Scenario: Create Meeting Room Without Name
    When I send a POST request to "/v1/meeting_rooms" with the following:
      | capacity   | '100' |
    Then the following json response is sent:
    """
    {"name":["can't be blank"]}
    """

  Scenario: Create Meeting Room Without Capacity
    When I send a POST request to "/v1/meeting_rooms" with the following:
      | name | gyan |
    Then the following json response is sent:
    """
    {"capacity":["can't be blank"]}
    """
