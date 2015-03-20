ActiveAdmin.register Game do
  permit_params :round_id, :winning_team_id, team_ids: []

  index do
    selectable_column
    id_column

    column :round do |game|
      game.round.name
    end

    column :teams do |game|
      game.teams.map(&:name).join(' vs ')
    end

    column :winning_team

    actions
  end

  form do |f|
    f.semantic_errors

    f.input :round
    f.input :winning_team
    f.input :victory_margin

    if f.object.new_record?
      f.inputs "Teams" do
        f.input :teams, as: :check_boxes, collection: Team.all # Use formtastic to output my collection of checkboxes
      end
    end

    f.actions
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
