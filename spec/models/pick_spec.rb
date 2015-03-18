require 'rails_helper'

RSpec.describe Pick, type: :model do
  it 'should be valid from factory' do
    expect(Fabricate.build(:pick)).to be_valid
  end

  context 'validation associations' do
    let(:game) { Fabricate :game }

    it 'should need a game, team, user' do
      pick = Pick.new
      expect(pick).not_to be_valid

      pick.game = game
      expect(pick).not_to be_valid

      pick.team = game.teams.last
      expect(pick).not_to be_valid

      pick.round = game.round
      expect(pick).not_to be_valid

      pick.user = Fabricate :user
      expect(pick).to be_valid
    end

    it 'is not valid if the team does not belong to the game' do
      pick = Fabricate :pick
      pick.team = Fabricate :team

      expect(pick).not_to be_valid
      expect(pick.errors).to include(:team)
    end

    it 'is not valid if it is after the start of the round' do
      pick = Fabricate.build :pick
      pick.round.starts_at = Time.zone.now - 5.minutes
      pick.round.save!

      expect(pick).not_to be_valid
      expect(pick.errors).to include(:base)
    end
  end
end
