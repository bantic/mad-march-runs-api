class RoundSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_active, :is_in_progress, :is_locked, :starts_at_ms

  has_many :games

  def is_active
    object.active?
  end

  def is_in_progress
    object.in_progress?
  end

  def is_locked
    object.locked?
  end
end
