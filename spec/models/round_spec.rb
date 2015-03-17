require 'rails_helper'

RSpec.describe Round, type: :model do
  context 'active' do
    it 'is active if it starts after now and has games' do
      starts_at = 5.minutes.from_now

      round = Fabricate(:round, starts_at:starts_at)
      round.games << Fabricate(:game)

      expect(round).to be_active

      round.games.clear

      expect(round).not_to be_active

      round.games << Fabricate(:game)

      expect(round).to be_active

      round.starts_at = 5.minutes.ago

      expect(round).not_to be_active
    end
  end

  context 'in_progress' do
    it 'is in progress if it is during the same day that it started' do
      today = Time.zone.now
      round = Fabricate(:round, starts_at:today)
      expect(round).to be_in_progress

      yesterday = today.beginning_of_day - 5.minutes
      round.starts_at = yesterday
      expect(round).not_to be_in_progress

      tomorrow = today.end_of_day + 5.minutes
      round.starts_at = tomorrow
      expect(round).not_to be_in_progress
    end
  end
end
