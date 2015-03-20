require 'rails_helper'

RSpec.describe Game, type: :model do
  context '#winning_team' do
    let(:game) { Fabricate(:game) }

    it 'must be one of the teams playing' do
      game.winning_team = game.teams.first
      expect(game).to be_valid

      game.winning_team = Fabricate(:team)
      expect(game).not_to be_valid

      expect(game.errors).to include(:winning_team)
    end
  end
end
