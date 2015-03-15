require 'rails_helper'

RSpec.describe TeamSerializer, type: :serializer do
  let(:team) { Fabricate :team }
  let(:serializer) { TeamSerializer.new(team) }
  let(:serialized) { serializer.as_json }

  subject { serialized }
  its(:keys) { should include('teams') }

  context 'serialized team' do
    subject { serialized['teams'][0] }

    its(:keys) { should include('id') }
    its(:keys) { should include('name') }
    its(:keys) { should include('seed') }
  end
end
