# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :meeting_rooms, through: :bookings
end
