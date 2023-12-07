class DropCountyTransactions < ActiveRecord::Migration[6.1]
  def up
    drop_table :county_transactions
  end

  def down
    create_table :county_transactions do |t|
      t.bigint :candidate_committee_id
      t.bigint :import_id
      t.string :filer_name
      t.datetime :rpt_date
      t.string :rec_type
      t.string :loan_type
      t.string :entity_cd
      t.string :entity_name_last
      t.string :entity_name_first
      t.string :ctrib_prefix
      t.string :ctrib_suffix
      t.string :entity_adr1
      t.string :entity_adr2
      t.string :entity_city
      t.string :entity_st
      t.string :entity_zip4
      t.string :entity_emp
      t.string :entity_occ
      t.string :entity_self
      t.string :tran_type
      t.date :tran_date
      t.float :amount
      t.float :amt_beg
      t.integer :expn_code
      t.string :description
      t.string :agent_name_last
      t.string :agent_name_first
      t.string :agent_prefix
      t.string :agent_suffix
      t.string :cmte_id
      t.datetime :created_at
      t.datetime :updated_at
      # Add index specifications if needed
    end
  end
end
