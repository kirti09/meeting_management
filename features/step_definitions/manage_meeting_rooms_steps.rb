# frozen_string_literal: true

When('I send a DELETE request to {string} with id') do |string|
  @meeting_room = MeetingRoom.create!(name: 'Test', capacity: 50)
  url = string + @meeting_room.id.to_s
  page.driver.delete(url)
end

Then(/^the response status should be "(.*)"$/) do |response_code|
  expect(page.status_code).to eq(response_code.to_i)
end

And('the same meeting_room can not find') do
  @meeting_room = MeetingRoom.where(name: 'Test')
  expect(@meeting_room.count).to eq(0)
end

When(/^I send a POST request to "(.*)" with the following:$/) do |endpoint, table|
  page.driver.post(endpoint, table.rows_hash)
end

Then(/^the following json response is sent:$/) do |message|
  JSON.parse(page.body) == JSON.parse(message)
end

And(/^the response status should be "(.*)"$/) do |response_code|
  expect(page.status_code).to eq(response_code.to_i)
end
