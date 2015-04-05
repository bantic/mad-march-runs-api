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

    it 'is not valid if the user has already picked for that round' do
      old_pick = Fabricate :pick

      user = old_pick.user.reload
      expect(user.picks.length).to eq 1

      new_game = Fabricate(:game, round:old_pick.round)
      pick = Fabricate.build(:pick, user:user, game:new_game, round:old_pick.round)
      expect(pick).not_to be_valid
      expect(pick.errors).to include(:round)
    end

    it 'is not valid if the user has already picked that team' do
      old_pick = Fabricate :pick

      old_team = old_pick.team
      user = old_pick.user.reload

      new_game = Fabricate(:game, teams: [old_team, Fabricate(:team)])
      pick = Fabricate.build(:pick, user:user, team:old_team, game:new_game)
      expect(pick).not_to be_valid
      expect(pick.errors).to include(:team)
    end
  end
end
