class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  belongs_to :team

  validates :user, presence: true
  validates :game, presence: true
  validates :team, presence: true

  validate :team_belongs_to_game
  validate :round_has_not_started

  private

  def round_has_not_started
    round = game.try(:round)
    return unless round

    if Time.zone.now > round.starts_at
      errors.add(:base, 'Round has already started, too late to pick')
      return true
    end
  end

  def team_belongs_to_game
    return unless game && team
    if !game.teams.include?(team)
      errors.add(:team, 'is not playing in this game')
      return true
    end
  end
end
