# frozen_string_literal: true

When(/^I send a POST request to "(.*)" with the following:$/) do |endpoint, table|
  page.driver.post(endpoint, table.rows_hash)
end

When(/^I send a DELETE request to "(.*)" with the following:$/) do |endpoint, _table|
  page.driver.delete(endpoint)
end

Then(/^the response status should be "(.*)"$/) do |response_code|
  expect(page.status_code).to eq(response_code.to_i)
end

Then(/^the following json response is sent:$/) do |message|
  expect(page.body).to eq(message)
end

# Then('the response status should be "422" and JSON:') do |int, doc_string|
#   expect(page.status_code).to be(int)
#   expect(page.body).to be(doc_string)
# end
