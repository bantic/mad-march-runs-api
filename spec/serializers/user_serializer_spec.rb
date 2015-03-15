require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  let(:user) { Fabricate :user }
  let(:serializer) { UserSerializer.new(user) }
  let(:serialized) { serializer.as_json }

  it { expect(user.teams.length).not_to eql 0 }

  subject { serialized }
  its(:keys) { should include('user') }

  context 'serialized user' do
    subject { serialized['user'] }

    its(:keys) { should include(:id) }
    its(:keys) { should include(:name) }
    its(:keys) { should include(:email) }
    its(:keys) { should include(:team_ids) }
    its(:keys) { should include(:can_select_teams) }

    context 'serialized teams' do
      subject { serialized['user'][:team_ids] }
      its(:length) { should eql user.teams.length }
      it { should eql user.teams.map(&:id) }
    end
  end
end
