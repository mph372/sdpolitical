ActiveAdmin.register Person do
  permit_params :first_name, :last_name, :email, :birthdate, :party, :district_id # add other attributes as needed
    # Disabling filters entirely


  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :birthdate
    column :party
    column :district
    actions
  end

  filter :first_name
  filter :last_name


  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :birthdate, as: :datepicker
      f.input :party
      f.input :district
      # Add other inputs as needed
    end
    f.actions
  end
end
