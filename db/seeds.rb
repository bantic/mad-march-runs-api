# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

File.open(Rails.root.join('db','data','teams_seeds.txt')) do |f|
  f.each_line do |line|
    name, seed, region, logo_path = line.strip.split('|')

    team = Team.where(name:name).first || Team.new(name:name)
    team.seed = seed
    team.region = region
    team.logo_path = logo_path
    team.save!
  end
end

rounds = [
  ['Round of 64 Day 1', Time.zone.local(2015, 3, 19, 9, 0)],
  ['Round of 64 Day 2', Time.zone.local(2015, 3, 20, 9, 0)],
  ['Round of 32 Day 1', Time.zone.local(2015, 3, 21, 9, 0)],
  ['Round of 32 Day 2', Time.zone.local(2015, 3, 22, 9, 0)],
  ['Sweet 16 Day 1', Time.zone.local(2015, 3, 26, 9, 0)],
  ['Sweet 16 Day 2', Time.zone.local(2015, 3, 27, 9, 0)],
  ['Elite 8 Day 1', Time.zone.local(2015, 3, 28, 9, 0)],
  ['Elite 8 Day 2', Time.zone.local(2015, 3, 29, 9, 0)],
  ['Final Four', Time.zone.local(2015, 4, 4, 9, 0)],
  ['Championship Game', Time.zone.local(2015, 4, 6, 9, 0)]
]

rounds.each do |name, time|
  round = Round.where(name:name).first || Round.new(name:name)
  round.starts_at = time
  round.save!
end
