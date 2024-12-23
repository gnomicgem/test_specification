require 'rails_helper'

RSpec.describe SkillsController, type: :controller do
  let(:valid_attributes) do
    { name: 'Ruby' }
  end

  let(:invalid_attributes) do
    { name: '' }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Skill and returns success response' do
        expect {
          post :create, params: { skill: valid_attributes }
        }.to change(Skill, :count).by(1)

        expect(response).to have_http_status(201)
        json_response = JSON.parse(response.body)
        expect(json_response['skill']['name']).to eq('Ruby')
        expect(json_response['message']).to eq('Skill was successfully created.')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Skill and returns error response' do
        expect {
          post :create, params: { skill: invalid_attributes }
        }.not_to change(Skill, :count)

        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("Name can't be blank")
      end
    end
  end
end
