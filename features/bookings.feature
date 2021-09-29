Feature: Testing meeting room booking API
  As a user
  I want to book a meeting room

  Background:
    Given I am a registered user

  Scenario: Booking an available meeting room
    Given A meeting room is available
    When I make a POST api request to endpoint '/v1/bookings' with below params:
      | start_time | 2021-09-29 10:00:00 |
      | end_time   | 2021-09-29 10:30:00 |
      | date       | 2021-09-29 |
    Then my booking is made successfully
    And I receive valid response code '201'

  Scenario: Booking an unavailable meeting room
    Given A meeting room is unavailable
    When I make a POST api request to endpoint '/v1/bookings' with below params:
      | start_time | 2021-09-29 10:00:00 |
      | end_time   | 2021-09-29 10:30:00 |
      | date       | 2021-09-29 |
    Then I receive an error response