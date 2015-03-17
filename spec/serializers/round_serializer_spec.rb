require 'rails_helper'

RSpec.describe RoundSerializer, type: :serializer do
  let(:round) { Fabricate :round }
  let(:serializer) { RoundSerializer.new(round) }
  let(:serialized) { serializer.as_json }

  subject { serialized }
  its(:keys) { should include('round') }
  its(:keys) { should include('games') }

  context 'serialized round' do
    subject { serialized['round'] }

    its(:keys) { should include(:id) }
    its(:keys) { should include(:name) }
    its(:keys) { should include(:is_active) }
    its(:keys) { should include(:is_in_progress) }
  end
end
