# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe V1::MeetingRoomsController do
  describe 'POST #create' do
    # valid params
    let(:valid_params) { { name: 'varta', capacity: 10 } }
    context 'when the request is valid' do
      before { post 'create', params: valid_params }
      it 'creates a meeting_room' do
        response_body = JSON.parse(response.body)
        expect(response_body['name']).to eq('varta')
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when the request is invalid' do
      before { post 'create', params: { name: '', capacity: 50 } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a validation failure message' do
        expect(JSON.parse(response.body))
          .to include('name' => ["can't be blank"])
      end
    end

    context 'when the request is invalid' do
      before { post 'create', params: { name: 'gyan', capacity: '' } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a validation failure message' do
        expect(JSON.parse(response.body))
          .to include('capacity' => ["can't be blank"])
      end
    end
  end

  # Test for DELETE /meeting_rooms/id
  describe 'DELETE #destroy' do
    before { post 'create', params: { name: 'default', capacity: 100 } }
    before { delete 'destroy', params: { id: 1 } }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
