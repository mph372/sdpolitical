class AddVendorToCommittee < ActiveRecord::Migration[5.2]
  def change
    add_reference :vendors, :committee, foreign_key: true
  end
end
