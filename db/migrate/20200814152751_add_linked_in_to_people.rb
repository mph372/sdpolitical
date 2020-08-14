class AddLinkedInToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :linkedin_url, :string
  end
end
