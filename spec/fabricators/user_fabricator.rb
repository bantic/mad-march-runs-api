Fabricator(:user) do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  teams { [ Fabricate(:team), Fabricate(:team), Fabricate(:team) ] }
end
