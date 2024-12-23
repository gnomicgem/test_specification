require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    {
      name: "John",
      patronymic: "Doe",
      surname: "Smith",
      email: "john.doe@example.com",
      age: 30,
      nationality: "American",
      country: "USA",
      gender: "Male",
      interests: [ "Reading", "Traveling" ],
      skills: [ "Ruby", "Rails" ]
    }
  end

  let(:invalid_attributes) do
    {
      name: "",
      email: "invalid_email",
      age: -1,
      interests: [],
      skills: []
    }
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new user and returns success response" do
        user = double("User", email: "john.doe@example.com", as_json: { 'email' => "john.doe@example.com" })
        outcome = double("Outcome", valid?: true, result: user)

        allow(Users::Create).to receive(:run).and_return(outcome)

        post :create, params: { user: valid_attributes }

        expect(response).to have_http_status(201)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('User was successfully created.')
        expect(json_response['user']['email']).to eq('john.doe@example.com')
      end
    end

    context "with invalid parameters" do
      it "returns an error response" do
        errors = double("Errors", full_messages: [ "Name can't be blank", "Age must be greater than 0" ])
        outcome = double("Outcome", valid?: false, errors: errors)

        allow(Users::Create).to receive(:run).and_return(outcome)

        post :create, params: { user: invalid_attributes }

        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("Name can't be blank", "Age must be greater than 0")
      end
    end
  end
end
