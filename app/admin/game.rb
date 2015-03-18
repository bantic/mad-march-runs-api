ActiveAdmin.register Game do


  index do
    selectable_column
    id_column

    column :round do |game|
      game.round.name
    end

    column :teams do |game|
      game.teams.map(&:name).join(' vs ')
    end

    column :starts_at do |game|
      game.round.starts_at
    end
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
