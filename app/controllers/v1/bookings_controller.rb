# frozen_string_literal: true

module V1
  class BookingsController < ApplicationController
    before_action :set_meeting_room, only: [:create]
    before_action :set_user, only: [:create]

    def create
      # Check whether Meeting Room is available.
      return render json: {error: 'Sorry, Meeting Room not available for booking.'}, status: :ok unless @meeting_room.is_available?

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
        render json: @booking.errors, status: :bad_request
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
