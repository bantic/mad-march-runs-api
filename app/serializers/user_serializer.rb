class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_many :teams

  def teams
    object.teams.map(&:id)
  end
end
