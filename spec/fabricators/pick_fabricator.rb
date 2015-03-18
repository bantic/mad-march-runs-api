Fabricator(:pick) do
  game
  team { |pick| pick[:game].teams.first }
  user
end
