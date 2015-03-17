class AddGamesTeams < ActiveRecord::Migration
  def change
    create_table :games_teams, id:false do |t|
      t.integer :game_id
      t.integer :team_id
    end

    add_index :games_teams, :team_id
    add_index :games_teams, :game_id
  end
end
