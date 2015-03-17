Fabricator(:game) do
  teams { [Fabricate(:team), Fabricate(:team)] }
  round
end
