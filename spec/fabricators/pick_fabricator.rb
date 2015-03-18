Fabricator(:pick) do
  game
  team { |pick| pick[:game].teams.first }
  round { |pick| pick[:game].round }
  user
end
