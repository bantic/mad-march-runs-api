class AddEliminatedFlagToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :is_eliminated, :boolean, default: false
  end
end
