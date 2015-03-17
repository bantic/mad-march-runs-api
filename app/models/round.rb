class Round < ActiveRecord::Base
  has_many :games

  def active?
    starts_at > Time.zone.now && games.count > 0
  end

  def in_progress?
    now = Time.zone.now
    starts_at.beginning_of_day <= now &&
      starts_at.end_of_day >= now
  end
end
