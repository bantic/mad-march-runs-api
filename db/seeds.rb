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
