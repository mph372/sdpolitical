class RemoveDistrictsFromCandidates < ActiveRecord::Migration[5.2]
    def change
        remove_index :candidates, name: "index_candidates_on_district_id"
    end
end