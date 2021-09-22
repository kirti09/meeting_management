Given /^A POST request is made$/ do
  puts "hello"
  # post "/v1/meeting_rooms"
  end
  Then /^the result should be in JSON:$/ do |str|
  json_data=JSON.parse(last_response.body)
  json_data.should  == JSON.parse(str)
  end