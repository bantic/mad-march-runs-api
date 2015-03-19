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
  ['Round of 64 Day 1', Time.zone.local(2015, 3, 19, 11, 0)],
  ['Round of 64 Day 2', Time.zone.local(2015, 3, 20, 11, 0)],
  ['Round of 32 Day 1', Time.zone.local(2015, 3, 21, 11, 0)],
  ['Round of 32 Day 2', Time.zone.local(2015, 3, 22, 11, 0)],
  ['Sweet 16 Day 1', Time.zone.local(2015, 3, 26, 11, 0)],
  ['Sweet 16 Day 2', Time.zone.local(2015, 3, 27, 11, 0)],
  ['Elite 8 Day 1', Time.zone.local(2015, 3, 28, 11, 0)],
  ['Elite 8 Day 2', Time.zone.local(2015, 3, 29, 11, 0)],
  ['Final Four', Time.zone.local(2015, 4, 4, 11, 0)],
  ['Championship Game', Time.zone.local(2015, 4, 6, 11, 0)]
]

rounds.each do |name, time|
  round = Round.where(name:name).first || Round.new(name:name)
  round.starts_at = time
  round.save!
end

round1 = Round.where(name: 'Round of 64 Day 1').first
round2 = Round.where(name: 'Round of 64 Day 2').first

if round1.games.length > 0 || round.games.length > 0
  puts "Skipping import of games for round 1 and 2"
else
  round1.games.clear
  round2.games.clear
  round1.save!
  round2.save!
  File.open(Rails.root.join('db','data','teams.txt')) do |f|
    f.each_line do |line|
      next if line.strip.blank? || line.start_with?('Region')

      matcher = /\d+\. (.*) vs\. \d+\. (.*) Day (\d)/
      match = line.match(matcher)
      team1 = Team.where(name:match[1]).first
      team2 = Team.where(name:match[2]).first
      day = match[3]

      active_round = nil
      case day
      when '1'
        active_round = round1
      when '2'
        active_round = round2
      end

      game = Game.new(round:active_round)
      game.save!
      game.teams << team1
      game.teams << team2
      game.save!
      puts "Create game #{game.round.name} - #{game.teams.first.name} vs #{game.teams.last.name}"
    end
  end
end
