class AddJurisdictionsToImports < ActiveRecord::Migration[5.2]
  def change
    add_reference :imports, :jurisdiction, foreign_key: true
  end
end
