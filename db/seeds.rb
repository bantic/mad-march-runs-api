# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

File.open('./db/data/teams.txt') do |f|
  region = nil

  f.each_line do |line|
    next if line.blank?

    if line.start_with?('Region')
      region = line.match(/Region: (.*)$/)[1]
      next
    end

    match = line.strip.match(/^(\d+)\. (.*) vs\. (\d+)\. (.*)$/)

    team_seed = match[1]
    team_name = match[2]

    puts "Creating #{team_name} (#{team_name})"
    Team.create(name:team_name, seed:team_seed, region:region)

    team_seed = match[3]
    team_name = match[4]

    puts "Creating #{team_name} (#{team_name})"
    Team.create(name:team_name, seed:team_seed, region:region)
  end
end
