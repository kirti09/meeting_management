# frozen_string_literal: true

class MeetingRoom < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :capacity, presence: true
end
