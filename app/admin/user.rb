ActiveAdmin.register User do

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
