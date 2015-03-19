class Round < ActiveRecord::Base
  has_many :games, dependent: :destroy

  def active?
    starts_at > Time.zone.now && games.count > 0
  end

  def in_progress?
    now = Time.zone.now
    starts_at.beginning_of_day <= now &&
      starts_at.end_of_day >= now
  end

  def locked?
    Time.zone.now >= starts_at
  end

  def starts_at_ms
    starts_at.to_i*1000
  end
end
