Given('I am a registered user') do
  @user = User.create(first_name: 'user', last_name: 'one', email: 'user1@test.com')
end

Given('A meeting room is available') do
  @meeting_room = MeetingRoom.create(name: 'MR1', capacity: 10, is_available: true)
end

Given('A meeting room is unavailable') do
  @meeting_room = MeetingRoom.create(name: 'MR1', capacity: 15, is_available: false)
end

When('I make a POST api request to endpoint {string} with below params:') do |url, table|
  @payload = table.rows_hash.merge!(user_id: @user.id, meeting_room_id: @meeting_room.id)
  page.driver.post(url, @payload)
end

Then('my booking is made successfully') do
  booking = Booking.last
  expect(booking.user_id).to eq(@payload[:user_id])
  expect(booking.meeting_room_id).to eq(@payload[:meeting_room_id])
end

And('I receive valid response code {string}') do |http_code|
  expect(page.status_code).to eq(http_code.to_i)
end

Then('I receive an error response') do
  JSON.parse(page.body)['error'] == 'Sorry, Meeting Room not available for booking.'
end

