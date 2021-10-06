# frozen_string_literal: true

FactoryBot.define do
  factory :meeting_room do
    name { Faker::Name.name }
    capacity { Faker::Number.within(range: 10..20) }
    is_available { true }
  end
end
