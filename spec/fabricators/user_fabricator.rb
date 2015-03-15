Fabricator(:user) do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  teams { [ Fabricate(:team), Fabricate(:team), Fabricate(:team) ] }
end
