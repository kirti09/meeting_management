Feature: Manage Bookings
  In order to cancel a Booking
  As a Manager
  I want to manage and cancel booking

 Scenario: A user can Cancel Booking by sending a DELETE request With Booking ID
  Given I have booking with 
    | start_time | 2021-09-29 10:00:00 |
    | end_time   | 2021-09-29 10:30:00 |
    | meeting_room_id | 1 |
    | user_id | 1 |
  When I send a DELETE request to "/v1/bookings/1" 
  Then the following json response is sent:
    """
    {"message": "Booking Cancelled Successfully!" }
    """
    And the response status should be "200" 


  Scenario: A user cannot Cancel Booking by sending a DELETE request With invalid Booking ID
    Given I have booking with
      | start_time | 2021-09-29 10:00:00 |
      | end_time   | 2021-09-29 10:30:00 |
      | meeting_room_id | 1 |
      | user_id | 1 |
    When I send a DELETE request to "/v1/bookings/1000"
    Then the following json response is sent:
      """
      {"message": "Booking not found" }
      """
      And the response status should be "422"
