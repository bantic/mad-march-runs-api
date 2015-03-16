class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :seed, :region, :logo_url
end
