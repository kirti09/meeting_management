# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user, inverse_of: :bookings
  belongs_to :meeting_room, inverse_of: :bookings

  validates :start_time, :end_time, :date, presence: true
end
