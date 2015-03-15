Fabricator(:team) do
  name { Faker::Name.name }
  seed { (1..16).to_a.sample }
end
