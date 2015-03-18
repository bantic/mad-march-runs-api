class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email,
    :can_select_teams, :is_admin

  has_many :teams
  has_many :picks
end
