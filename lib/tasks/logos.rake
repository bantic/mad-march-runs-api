namespace :logos do
  desc 'download logos and update teams'
  task :download => :environment do
    File.open(Rails.root.join('db','data','teams_with_logo_urls.txt')) do |f|
      f.each_line do |line|
        id, team_name, img_url = line.strip.split('|')
        clean_name = team_name.gsub(/[^a-zA-Z]/,'-').gsub(/--/,'-').downcase
        img_filename = "team-logo-#{id}-#{clean_name}.gif"
        cmd = "curl #{img_url} > app/assets/images/team-logos/#{img_filename}"
        puts cmd
        `#{cmd}`

        t = Team.find(id)
        t.logo_path = "team-logos/#{img_filename}"
        t.save!
        sleep 1
      end
    end
  end

  desc 'match to teams'
  task :match => :environment do
    File.open( Rails.root.join('db','data','team_names_with_logos.txt') ) do |f|
      teams_with_logos = []

      f.each_line do |line|
        tokens = line.split(' ')
        img = tokens.pop
        mascot = tokens.pop # this doesn't work for multi-word mascots
        team_name = tokens.join(' ')
        teams_with_logos << {name: team_name, img: img}
      end

      fuzzy = FuzzyMatch.new(teams_with_logos, read: :name)

      Team.all.each do |team|
        if found = fuzzy.find(team.name)
          puts [team.id,team.name,found[:img]].join('|')
        end
      end
    end
  end

  def clean_text text
    text.lstrip.sub(/(\n|\t).*/m,'')
  end

  def scrape_url url
    agent = Mechanize.new
    page = agent.get url

    logos = page.search('ul.logoWall li')

    logos.each do |logo|
      team_name = clean_text logo.text
      img_url   = logo.search('img')[0].attributes['src'].value
      puts "#{team_name} #{img_url}"
    end
  end

  desc 'scape logos for all teams'
  task :scrape => :environment do
    urls = [
      'http://www.sportslogos.net/teams/list_by_league/30/NCAA_Division_I_a-c/NCAA_a-c/logos/',
      'http://www.sportslogos.net/teams/list_by_league/31/NCAA_Division_I_d-h/NCAA_d-h/logos/',
      'http://www.sportslogos.net/teams/list_by_league/32/NCAA_Division_I_i-m/NCAA_i-m/logos/',
      'http://www.sportslogos.net/teams/list_by_league/33/NCAA_Division_I_n-r/NCAA_n-r/logos/',
      'http://www.sportslogos.net/teams/list_by_league/34/NCAA_Division_I_s-t/NCAA_s-t/logos/',
      'http://www.sportslogos.net/teams/list_by_league/35/NCAA_Division_I_u-z/NCAA_u-z/logos/'
    ]

    urls.each {|u| scrape_url u }
  end
end
