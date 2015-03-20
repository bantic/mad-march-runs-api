class AddVictoryMarginToGames < ActiveRecord::Migration
  def change
    add_column :games, :victory_margin, :integer
  end
end
