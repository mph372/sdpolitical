class CreateCandidateCommittees < ActiveRecord::Migration[6.1]
  def change
    unless table_exists?(:candidate_committees)
      create_table :candidate_committees do |t|
        t.bigint :person_id
        t.bigint :report_id
        t.string :name
        t.string :cycle
        t.string :status
        t.boolean :primary_committee, default: false
        t.bigint :candidate_id

        t.index :person_id
        t.index :report_id
        t.index :candidate_id
      end
    end
  end
end
