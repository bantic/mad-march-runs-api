require 'rails_helper'

RSpec.describe PickSerializer, type: :serializer do
  let(:pick) { Fabricate :pick }
  let(:serializer) { PickSerializer.new(pick) }
  let(:serialized) { serializer.as_json }

  subject { serialized }
  its(:keys) { should include('pick') }
  its(:keys) { should include('teams') }
  its(:keys) { should include('games') }
  its(:keys) { should_not include('users') }

  context 'serialized pick' do
    subject { serialized['pick'] }
    its(:keys) { should include(:id) }
    its(:keys) { should include('team_id') }
    its(:keys) { should include('game_id') }
    its(:keys) { should include(:user_id) }
  end
end
