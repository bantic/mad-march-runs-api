class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.column :name, :string
      t.column :starts_at, :datetime

      t.timestamps null: false
    end
  end
end
