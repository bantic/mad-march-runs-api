class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :can_select_teams, :team_ids

  def team_ids
    object.teams.map(&:id)
  end
end
