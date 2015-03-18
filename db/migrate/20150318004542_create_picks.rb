class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :game_id
      t.integer :user_id
      t.integer :team_id

      t.timestamps null: false
    end

    add_index :picks, :user_id
  end
end
