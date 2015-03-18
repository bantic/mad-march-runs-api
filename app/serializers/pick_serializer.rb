class PickSerializer < ActiveModel::Serializer
  attributes :id, :user_id

  has_one :team
  has_one :game
end
