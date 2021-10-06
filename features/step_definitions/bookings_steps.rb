# frozen_string_literal: true

Given(/^I am a registered user$/) do
  @user = FactoryBot.create(:user)
end

Given(/^A meeting room is "(.*)"$/) do |availability|
  availability == 'available' ? FactoryBot.create(:meeting_room) : FactoryBot.create(:meeting_room, is_available: false)
end

When(/^I make a POST api request to endpoint "(.*)" with below params:$/) do |url, table|
  table.hashes.each do |data|
    @payload = data.merge!(user_id: @user.id)
    page.driver.post(url, @payload)
  end
end

Then(/^my booking is made successfully$/) do
  booking = Booking.last
  expect(booking.user_id).to eq(@payload[:user_id])
  expect(booking.meeting_room_id).to eq(@payload[:meeting_room_id].to_i)
end

And(/^the response code is "(.*)"$/) do |http_code|
  expect(page.status_code).to eq(http_code.to_i)
end

Then(/^I receive the below error response:$/) do |error_response|
  expect(JSON.parse(page.body)).to eq(JSON.parse(error_response))
end

And(/^the time slot "(.*)" to "(.*)" is already booked$/) do |start_time, end_time|
  @user.bookings.create(start_time: start_time.to_datetime, end_time: end_time.to_datetime,
                        meeting_room: MeetingRoom.first)
end
