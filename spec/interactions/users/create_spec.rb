# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Create, type: :interaction do
  let(:valid_params) do
    {
      name: 'John',
      patronymic: 'Doe',
      surname: 'Smith',
      email: 'john@example.com',
      age: 25,
      nationality: 'American',
      country: 'USA',
      gender: 'male',
      interests: %w[ Reading Traveling ],
      skills: %w[ Ruby JavaScript ]
    }
  end

  let(:invalid_params) do
    {
      name: '',
      patronymic: 'Doe',
      surname: 'Smith',
      email: 'invalid_email',
      age: 25,
      nationality: 'American',
      country: 'USA',
      gender: 'male',
      interests: [ 'Reading' ],
      skills: [ 'Ruby' ]
    }
  end

  describe '#execute' do
    context 'when valid params are provided' do
      it 'associates the user with interests and skills' do
        user = Users::Create.run!(valid_params)
        allow(user.interests).to receive(:pluck).with(:name).and_return([ 'Reading', 'Traveling' ])
        allow(user.skills).to receive(:pluck).with(:name).and_return([ 'Ruby', 'JavaScript' ])

        expect(user.interests.pluck(:name)).to contain_exactly('Reading', 'Traveling')
        expect(user.skills.pluck(:name)).to contain_exactly('Ruby', 'JavaScript')
      end
    end

    context 'when invalid params are provided' do
      it 'adds validation errors' do
        result = Users::Create.run(invalid_params)
        expect(result.errors.messages[:email]).to include("invalid_email is not a valid email")
        expect(result.errors.messages[:name]).to include("can't be blank")
      end
    end
  end
end
