class CreateImports < ActiveRecord::Migration[5.2]
  def change
    create_table :imports do |t|
      t.references :candidate_committee, foreign_key: true

      t.timestamps
    end
  end
end
