ActiveAdmin.register User do
  permit_params :email, :password, team_ids: []

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    column :last_sign_in_at
    column :is_admin
    column :teams do |user|
      user.teams.map(&:name).join(',')
    end
    column :picks do |user|
      user.picks.map do |pick|
        "#{pick.round.name}: #{pick.team.name}"
      end.join(',')
    end
    actions
  end

  sidebar 'Runs Teams', :only => :show do
    table_for user.teams do |t|
      t.column("Team") { |team| team.name }
    end
  end

  form do |f|
    f.semantic_errors

    if f.object.new_record?
      f.input :email
      f.input :password
    end

    f.inputs "Teams" do # Make a panel that holds inputs for lifestyles
      f.input :teams, as: :check_boxes, collection: Team.all # Use formtastic to output my collection of checkboxes
    end
    para "Press cancel to return to the list without saving."
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
