class CandidateCommittee < ApplicationRecord
    belongs_to :person
    has_many :reports 
    has_many :imports
    
    

    def committee_status
        if status == "Open"
            
        elsif status == "Closed"
            "(Inactive)"
        end
    end

   scope :is_primary, -> {where(:primary_committee => true)}

    def only_one_primary
        if self.primary_committee?
        self.person.candidate_committees.is_primary.update_all(:primary_committee => false)
        end
    end

    def total_expenditures
        transactions.where(transaction_type: "EXPN").sum(:amount)
    end

    def median_donation
        a = Array.new
        transactions.where(transaction_type: "RCPT").each do |t|
           a << t.amount
        end
        sorted = a.sort # required
        #=> [1, 2, 3, 4, 5, 6, 7, 8]
        midpoint = a.length / 2 # integer division
        #=> 4
        if a.length.even?
        # median is mean of two values around the midpoint
        sorted[midpoint-1, 2].sum / 2.0
        else
        sorted[midpoint]
        end
    end

    def individual_percentage
        total_contributions = transactions.where(transaction_type: "RCPT").sum(:amount)
        individual_contributions = transactions.where(transaction_type: "RCPT").where(entity_type: "IND").sum(:amount)
        (individual_contributions / total_contributions) * 100
    end

    def self_fund
        a = Array.new
        transactions.where.not(transaction_type: "EXPN").where.not(transaction_type: "DEBT").each do |transaction|
         if "#{transaction.full_name}".similar(person.full_name) > 90 && transaction.amount != 0
           a << transaction
         end
       end
       transactions.where(fec_receipt_type: "15C").or(transactions.where(fec_receipt_type: "16C")).each do |transaction|
          a << transaction
      end       
       a
    end
    
def committee_compare
    committees = Hash.new
    a = Array.new
    transactions.each do |t| 
        a << t.full_name
    end
    CandidateCommittee.all.each do |c|
        b = Array.new
        if c.transactions.present?
            c.transactions.each do |t|
                b << t.full_name
            end
        end
        difference = a.count - b.count
        similar = a.count - difference
        percentage = (similar / a.count)*100
        committees[c] = percentage
    end
    committees.sort_by { |c, percentage| percentage }[0..2].map(&:first)
    
end


end
