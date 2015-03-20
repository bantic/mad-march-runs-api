class Game < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :picks

  belongs_to :round
  belongs_to :winning_team, class_name: 'Team'

  validate :winning_team_is_playing

  private

  def winning_team_is_playing
    return if !winning_team

    if !teams.include?(winning_team)
      errors.add(:winning_team, 'is not playing')
      return false
    end
  end
end
