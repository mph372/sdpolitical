class RemoveCampaigns < ActiveRecord::Migration[5.2]


      def change

        drop_table :campaign_candidates
        drop_table :campaigns
        
        drop_table :candidates, force: :cascade
      end


end
