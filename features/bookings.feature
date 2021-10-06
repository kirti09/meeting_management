Feature: Testing meeting room booking API
  As a user
  I want to book a meeting room

  Background:
    Given I am a registered user

  Scenario: Booking an available meeting room
    Given A meeting room is "available"
    When I make a POST api request to endpoint "/v1/bookings" with below params:
      | start_time | end_time | meeting_room_id |
      | 2099-09-29 10:00:00 | 2099-09-29 10:30:00 | 1 |
    Then my booking is made successfully
    And the response code is "201"

  Scenario: Booking an unavailable meeting room
    Given A meeting room is "unavailable"
    When I make a POST api request to endpoint "/v1/bookings" with below params:
      | start_time | end_time | meeting_room_id |
      | 2099-09-29 10:00:00 | 2099-09-29 10:30:00 | 1 |
    Then I receive the below error response:
    """
    {"meeting_room_id":["Meeting Room not available for booking."]}
    """
    And the response code is "422"

  Scenario: Booking an unavailable time slot for a meeting room
    Given A meeting room is "available"
    And the time slot "2099-09-29 10:00:00" to "2099-09-29 10:30:00" is already booked
    When I make a POST api request to endpoint "/v1/bookings" with below params:
      | start_time | end_time | meeting_room_id |
      | 2099-09-29 10:00:00 | 2099-09-29 10:30:00 | 1 |
    Then I receive the below error response:
    """
    {"start_time":["Requested time slot not available."]}
    """
    And the response code is "422"