class AddRoundToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :round_id, :integer
    add_index :picks, :round_id
  end
end
