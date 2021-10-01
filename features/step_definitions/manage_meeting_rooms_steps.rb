# frozen_string_literal: true

Given('the following meeting_room exist') do |table|
  @meeting_room = MeetingRoom.create!(table.rows_hash)
end

When('I send a DELETE request to {string} with id') do |string, table|
  @meeting_room = MeetingRoom.find_by(table.rows_hash)
  url = string + @meeting_room.id.to_s
  page.driver.delete(url)
end

Then(/^the response status should return "(.*)"$/) do |response_code|
  expect(page.status_code).to eq(response_code.to_i)
end

And('the following meeting_room should not exist') do |table|
  @meeting_room = MeetingRoom.where(table.rows_hash)
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
