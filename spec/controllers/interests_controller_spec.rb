require 'rails_helper'

RSpec.describe InterestsController, type: :controller do
  let(:valid_attributes) do
    { name: 'Reading' }
  end

  let(:invalid_attributes) do
    { name: '' }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Interest and returns success response' do
        expect {
          post :create, params: { interest: valid_attributes }
        }.to change(Interest, :count).by(1)

        expect(response).to have_http_status(201)
        json_response = JSON.parse(response.body)
        expect(json_response['interest']['name']).to eq('Reading')
        expect(json_response['message']).to eq('Interest was successfully created.')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Interest and returns error response' do
        expect {
          post :create, params: { interest: invalid_attributes }
        }.not_to change(Interest, :count)

        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("Name can't be blank")
      end
    end
  end
end
