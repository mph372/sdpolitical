class CreateCandidateCommittee < ActiveRecord::Migration[5.2]
  def change
    create_table :candidate_committees do |t|
      t.references :person, foreign_key: true
      t.references :report, foreign_key: true
      t.string :name
      t.string :cycle
      t.string :status
    end
  end
end
