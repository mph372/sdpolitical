class RemoveForeignKeyFromCandidates < ActiveRecord::Migration[5.2]
  def change
    if foreign_key_exists?(:committees, :candidates)
      remove_foreign_key :committees, :candidates
    end
  end
end
