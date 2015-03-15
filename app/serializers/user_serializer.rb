class UserSerializer < BaseSerializer
  schema do
    type 'user'
    map_properties :id, :name, :email
  end
end
