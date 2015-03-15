class TeamSerializer < BaseSerializer
  schema do
    type 'team'

    map_properties :id, :name, :seed
  end
end
