Given('I have booking with') do |table|
  @user = User.create(first_name: 'test', last_name: 'user', email: 'testuser_@test.com')
  @meeting_room = MeetingRoom.create(name: 'varta', capacity: 100)
  @booking = Booking.create(table.rows_hash)
end

When(/^I send a DELETE request to "(.*)"$/) do |endpoint|
  page.driver.delete(endpoint)
end

Then(/^the following json response is sent:$/) do |message|
  JSON.parse(page.body) == JSON.parse(message)
end

And(/^the response status should be "(.*)"$/) do |response_code|
  expect(page.status_code).to eq(response_code.to_i)
end

