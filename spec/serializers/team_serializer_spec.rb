require 'rails_helper'

RSpec.describe TeamSerializer, type: :serializer do
  let(:team) { Fabricate :team }
  let(:serializer) { TeamSerializer.new(team) }
  let(:serialized) { serializer.as_json }

  subject { serialized }
  its(:keys) { should include('team') }

  context 'serialized team' do
    subject { serialized['team'] }

    its(:keys) { should include(:id) }
    its(:keys) { should include(:name) }
    its(:keys) { should include(:seed) }
    its(:keys) { should include(:region) }
    its(:keys) { should include(:logo_url) }
    its(:keys) { should include(:is_eliminated) }
  end
end
