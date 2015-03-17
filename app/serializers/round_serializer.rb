class RoundSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_active, :is_in_progress

  has_many :games

  def is_active
    object.active?
  end

  def is_in_progress
    object.in_progress?
  end
end