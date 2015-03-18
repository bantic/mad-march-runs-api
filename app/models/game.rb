class Game < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :picks

  belongs_to :round
  belongs_to :winning_team, class_name: 'Team'
end
