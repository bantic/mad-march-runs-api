require 'rails_helper'

RSpec.describe GameSerializer, type: :serializer do
  let(:game) { Fabricate :game }
  let(:serializer) { GameSerializer.new(game) }
  let(:serialized) { serializer.as_json }

  subject { serialized }
  its(:keys) { should include('game') }
  its(:keys) { should include('teams') }

  context 'serialized game' do
    subject { serialized['game'] }

    its(:keys) { should include(:id) }
  end
end
