class RemoveUnusedGameTeamColumns < ActiveRecord::Migration
  def change
    remove_column :games, :team1_id
    remove_column :games, :team2_id
  end
end
