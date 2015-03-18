class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  belongs_to :team
  belongs_to :round

  validates :user,  presence: true
  validates :game,  presence: true
  validates :team,  presence: true
  validates :round, presence: true

  validate :team_belongs_to_game
  validate :game_belongs_to_round
  validate :round_has_not_started

  private

  def game_belongs_to_round
    return unless game

    if game.round != round
      errors.add(:base, 'This game is not in this round')
      return true
    end
  end

  def round_has_not_started
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
