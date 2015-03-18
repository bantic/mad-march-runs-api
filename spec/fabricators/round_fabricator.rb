Fabricator(:round) do
  name { sequence(:name) {|i| "round #{i}"} }
  starts_at { Time.zone.now + 5.minutes }
end
