ActiveAdmin.register Team do
  permit_params :is_eliminated

  index do
    selectable_column
    id_column

    column :name
    column :seed
    column :region
    column :is_eliminated

    column "Selected count" do |team|
      team.users.count
    end
    actions
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
