# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user, inverse_of: :bookings
  belongs_to :meeting_room, inverse_of: :bookings

  validates :start_time, :end_time, presence: true

  validate :greater_than_today, if: -> { start_time.present? && end_time.present? }
  validate :end_datetime_after_start_datetime, if: -> { start_time.present? && end_time.present? }
  validate :meeting_room_availability
  validate :time_slot_availability, if: :verify_meeting_room?

  private

  # Start time and End time must be greater the current datetime
  def greater_than_today
    errors.add :start_time, 'Start time must be greater then current time.' if start_time.before? Time.now
    errors.add :end_time, 'End time must be greater then current time.' if end_time.before? Time.now
  end

  # Validates End time to be greater than Start time
  def end_datetime_after_start_datetime
    errors.add :end_time, 'End time must be after Start time.' if end_time < start_time
  end

  # Get meeting room availability status
  def verify_meeting_room?
    meeting_room.is_available?
  end

  # Check whether meeting room is available for booking or not
  def meeting_room_availability
    errors.add :meeting_room_id, 'Meeting Room not available for booking.' unless verify_meeting_room?
  end

  # Check whether requested time slot is available or not.
  def time_slot_availability
    if meeting_room.bookings.where('end_time > ? AND start_time < ?', start_time, end_time).present?
      errors.add :start_time, 'Requested time slot not available.'
    end
  end
end
