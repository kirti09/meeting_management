# frozen_string_literal: true

# Controller to manage meeting rooms
module V1
  class MeetingRoomsController < ApplicationController
    skip_before_action :verify_authenticity_token

    before_action :set_meeting_room, only: :destroy

    def create
      @meeting_room = MeetingRoom.create(meeting_room_params)
      if @meeting_room.save
        render json: { id: @meeting_room.id, name: @meeting_room.name, capacity: @meeting_room.capacity },
               status: :created
      else
        render json: @meeting_room.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @meeting_room.destroy
      render json: 'Room Deleted Successfully!', status: 204
    end

    private

    def meeting_room_params
      params.permit(:name, :capacity)
    end

    def set_meeting_room
      @meeting_room = MeetingRoom.find_by(params[:id])
    end
  end
end
