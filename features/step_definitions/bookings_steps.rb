# frozen_string_literal: true

Given(/^I am a registered user$/) do
  @user = User.create(first_name: 'user', last_name: 'one', email: 'user1@test.com')
end

Given(/^A meeting room is "(.*)"$/) do |availability|
  @meeting_room = if availability == 'available'
                    MeetingRoom.create(name: 'MR1', capacity: 10, is_available: true)
                  else
                    MeetingRoom.create(name: 'MR1', capacity: 15, is_available: false)
                  end
end

When(/^I make a POST api request to endpoint "(.*)" with below params:$/) do |url, table|
  @payload = table.rows_hash.merge!(user_id: @user.id, meeting_room_id: @meeting_room.id)
  page.driver.post(url, @payload)
end

Then(/^my booking is made successfully$/) do
  booking = Booking.last
  expect(booking.user_id).to eq(@payload[:user_id])
  expect(booking.meeting_room_id).to eq(@payload[:meeting_room_id])
end

And(/^the response code is "(.*)"$/) do |http_code|
  expect(page.status_code).to eq(http_code.to_i)
end

Then(/^I receive the below error response:$/) do |error_response|
  expect(JSON.parse(page.body)).to eq(JSON.parse(error_response))
end

When(/^I repeat the POST api request to endpoint "(.*)" with same params:$/) do |url, table|
  @payload = table.rows_hash.merge!(user_id: @user.id, meeting_room_id: @meeting_room.id)
  page.driver.post(url, @payload)
end
