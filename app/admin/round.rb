ActiveAdmin.register Round do

  index do
    selectable_column
    id_column

    column :name

    column "Total Picks" do |round|
      round.games.inject(0) { |sum, game| sum += game.picks.count }
    end

    column :starts_at
  end


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
