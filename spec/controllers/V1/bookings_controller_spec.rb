# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::BookingsController do
  let!(:user) { create(:user) }
  let!(:available_meeting_room) { create(:meeting_room) }
  let!(:unavailable_meeting_room) { create(:meeting_room, is_available: false) }
  let!(:meeting_date) { Faker::Date.between(from: Date.today, to: 1.week.from_now) }
  let!(:past_date) { Time.now - 1.day }

  describe 'Booking a meeting room: POST /v1/bookings' do
    context 'when valid attributes are provided' do
      context 'and the meeting room is available' do
        let(:valid_with_available) do
          {
            user_id: user.id,
            meeting_room_id: available_meeting_room.id,
            start_time: "#{meeting_date}T05:00:00",
            end_time: "#{meeting_date}T05:30:00"
          }
        end

        before { post 'create', params: valid_with_available }

        it 'creates a booking and returns a response' do
          expect(json).not_to be_empty
          expect(json['user_id']).to eq(user.id)
          expect(json['meeting_room_id']).to eq(available_meeting_room.id)
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'and the meeting room is unavailable' do
        let(:valid_with_unavailable) do
          {
            user_id: user.id,
            meeting_room_id: unavailable_meeting_room.id,
            start_time: "#{meeting_date}T05:00:00",
            end_time: "#{meeting_date}T05:30:00"
          }
        end

        before { post 'create', params: valid_with_unavailable }

        it 'returns response with an error message' do
          expect(json).not_to be_empty
          expect(json['meeting_room_id'].first).to match(/Meeting Room not available for booking./)
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end
    end

    context 'when I book a meeting room with unavailable time slot' do
      let(:unavailable_time_slot) do
        {
          user_id: user.id,
          meeting_room_id: available_meeting_room.id,
          start_time: "#{meeting_date}T05:00:00",
          end_time: "#{meeting_date}T06:00:00"
        }
      end

      before { post 'create', params: unavailable_time_slot }
      before { post 'create', params: unavailable_time_slot }

      it 'returns response with an error message' do
        expect(json).not_to be_empty
        expect(json['start_time'].first).to match(/Requested time slot not available./)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when invalid attributes are provided' do
      let(:invalid_attributes) do
        {
          user_id: user.id,
          meeting_room_id: available_meeting_room.id,
          start_time: nil,
          end_time: nil
        }
      end

      before { post 'create', params: invalid_attributes }

      it 'returns an error response' do
        expect(json['start_time'].first).to match(/can't be blank/)
        expect(json['end_time'].first).to match(/can't be blank/)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when end time is greater than start time' do
      let(:invalid_attributes) do
        {
          user_id: user.id,
          meeting_room_id: available_meeting_room.id,
          start_time: "#{meeting_date}T07:00:00",
          end_time: "#{meeting_date}T06:00:00"
        }
      end

      before { post 'create', params: invalid_attributes }

      it 'returns an error response' do
        expect(json['end_time'].first).to match(/End time must be after Start time./)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when start time and end time less than current time' do
      let(:invalid_attributes) do
        {
          user_id: user.id,
          meeting_room_id: available_meeting_room.id,
          start_time: "#{past_date}T05:00:00",
          end_time: "#{past_date}T06:00:00"
        }
      end

      before { post 'create', params: invalid_attributes }

      it 'returns an error response' do
        expect(json['start_time'].first).to match(/Start time must be greater then current time./)
        expect(json['end_time'].first).to match(/End time must be greater then current time./)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
