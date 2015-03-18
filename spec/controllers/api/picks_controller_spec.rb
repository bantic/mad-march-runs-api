require 'rails_helper'

RSpec.describe Api::PicksController, type: :controller do
  describe 'create' do
    let(:user) { Fabricate :user }
    before { sign_in user }

    let(:game) { Fabricate(:game) }
    let(:teams) { game.teams }

    let(:params) { {
      pick: {
        user_id: user.id,
        game_id: game.id,
        team_id: teams.first.id
      }
    } }

    let(:request) { -> { post :create, params } }
    it { expect(request).to change(Pick, :count).by(1) }

    it 'creates a pick with the game and team specified' do
      request.call
      pick = Pick.last
      expect(pick.team).to eql teams.first
      expect(pick.game).to eql game
      expect(pick.user).to eql user
    end
  end
end
