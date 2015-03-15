require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let!(:user) { Fabricate :user }
  before { sign_in user }

  describe '#show' do
    let(:request) { -> { get :show, {id: user.id} } }

    subject { request.call }
    it { should serialize_to(UserSerializer, user) }
  end

  describe '#update' do
    let(:team) { Fabricate :team }
    let(:params) { {
      id: user.id,
      user: {team_ids:[team.id]}
    } }
    let(:request) { -> { put :update, params } }

    context 'user has no teams' do
      before { user.teams.clear; user.save! }

      it { expect(request).to change(user.teams, :count).by(1) }
    end

    context 'user has teams' do
      it { expect(user.teams).not_to be_empty }
      it 'should replace user teams' do
        request.call
        expect(user.reload.teams.to_a).to eql([team])
      end
    end
  end
end
