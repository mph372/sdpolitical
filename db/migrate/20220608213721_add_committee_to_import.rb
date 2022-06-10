class AddCommitteeToImport < ActiveRecord::Migration[5.2]
  def change
    add_reference :imports, :committee, foreign_key: true
  end
end
