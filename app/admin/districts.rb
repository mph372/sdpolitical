ActiveAdmin.register District do
  permit_params :name, :district

  index do
    selectable_column
    id_column
    column :name
    column :district
  
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :district
      
    end
    f.actions
  end
end
