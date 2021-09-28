# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::BookingsController do
  let!(:user) { create(:user) }
  let!(:meeting_room) { create(:meeting_room) }
  let!(:meeting_date) { Faker::Date.between(from: Date.today, to: 1.week.from_now) }

  describe 'Booking a meeting room: POST /v1/bookings' do
    context 'when valid attributes are provided' do
      let(:valid_attributes) do
        {
          user_id: user.id,
          meeting_room_id: meeting_room.id,
          start_time: "#{meeting_date}T05:00:00",
          end_time: "#{meeting_date}T05:30:00",
          date: meeting_date
        }
      end

      before { post 'create', params: valid_attributes }

      it 'creates a booking and returns a response' do
        res = JSON.parse(response.body)
        expect(res).not_to be_empty
        expect(res['user_id']).to eq(user.id)
        expect(res['meeting_room_id']).to eq(meeting_room.id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end
end
