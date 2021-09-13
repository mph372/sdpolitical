class CampaignFinanceModule < ApplicationRecord
  belongs_to :jurisdiction, optional: true
  belongs_to :district, optional: true


  def contribution_limit_output
    if self.contribution_limit == 0 || self.contribution_limit == nil
       "No Limit"
    else
       "$#{self.contribution_limit}"
    end
  end

  def corporate_contribution_output
    if self.corporate?
       "Allowed"
    else
       "Prohibited"
    end
  end

  def party_contribution_limit_output
    if self.party_limit == 0 || self.party_limit == nil
       "No Limit"
    else
         "$#{self.party_limit}"
    end
  end

  def pac_contribution_output
    if self.pac?
       "Allowed"
    else
         "Prohibited"
    end
  end

end
