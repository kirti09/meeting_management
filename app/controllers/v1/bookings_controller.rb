# frozen_string_literal: true

module V1
  class BookingsController < ApplicationController
    before_action :set_meeting_room
    before_action :set_user

    def create
      # Book a Meeting Room for a User
      @booking = @user.bookings.build(
        meeting_room: @meeting_room,
        start_time: params[:start_time],
        end_time: params[:end_time],
        date: params[:date]
      )
      # TODO: before save check whether the time slot is available, if not repond with 'Time slot not Available'

      if @booking.save
        render json: @booking, status: :created
      else
        render json: @booking.errors, status: :unprocessable_entity
      end
    end

    private

    def set_meeting_room
      @meeting_room = MeetingRoom.find(params[:meeting_room_id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
