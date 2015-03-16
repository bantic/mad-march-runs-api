class AddTeamLogoPath < ActiveRecord::Migration
  def change
    remove_column :teams, :logo_url, :string
    add_column :teams, :logo_path, :string
  end
end
