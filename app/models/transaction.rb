class Transaction < ApplicationRecord
  belongs_to :candidate_committee, optional: :true 
  belongs_to :import, optional: :true 
  belongs_to :contributor, optional: :true
  belongs_to :vendor, optional: :true
  validates :unique_key, uniqueness: true
  require "roo-xls"

  def self.import(candidate_committee, file)
    import = Import.new
    import.candidate_committee_id = candidate_committee.id
    import.save
    spreadsheet = open_spreadsheet(file) # open spreadsheet
    header = spreadsheet.row(1) # get header row
  if spreadsheet.cell(1,3) == "Committee_Type"
    # County Master Spreadsheet
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      t = Transaction.new
      t.candidate_committee_id = candidate_committee.id
      t.import_id = import.id
      t.transaction_type = row['Rec_Type'] 
      t.entity_type = row["Entity_Cd"]
      t.entity_last_name = row["Entity_Nam L"]
      t.entity_first_name = row["Entity_Nam F"]
      t.entity_city = row["Entity_City"]
      t.entity_state = row["Entity_ST"]
      t.entity_zip = row["Entity_ZIP4"]
      t.entity_employer = row["Entity_Emp"]
      t.entity_occupation = row["Entity_Occ"]
      t.description = row["Description"]
      if row["Tran_Date"] != nil 
        t.transaction_date = row["Tran_Date"]
      end
      t.amount = row["Amount"]
      t.expense_code = row["Expn_Code"]
      t.unique_key = "#{row["Filer_ID"]} #{row["Tran_ID"]}"
      t.save
      if t.transaction_type == "RCPT"
        t.add_to_contributor
      end
      if t.transaction_type == "EXPN"
        t.add_to_vendor
      end
      t.generate_full_name
    end
      
  elsif spreadsheet.cell(1,3) == "Report_Num"
contributions = spreadsheet.sheet_for("F460-A-Contribs")
expenditures = spreadsheet.sheet_for("F460-E-Expenditures")
# City Contributions Spreadsheet
  header = contributions.row(1)
  (2..contributions.last_row).each do |i|
    row = Hash[[header, contributions.row(i)].transpose]
    t = Transaction.new
    t.candidate_committee_id = candidate_committee.id
    t.import_id = import.id
    t.transaction_type = row['Rec_Type'] 
    t.entity_type = row["Entity_Cd"]
    t.entity_last_name = row["Ctrib_NamL"]
    t.entity_first_name = row["Ctrib_NamF"]
    t.entity_city = row["Ctrib_City"]
    t.entity_state = row["Ctrib_ST"]
    t.entity_zip = row["Ctrib_ZIP4"]
    t.entity_employer = row["Ctrib_Emp"]
    t.entity_occupation = row["Ctrib_Occ"]
    t.description = row["Ctrib_Dscr"]
    if row["Rcpt_Date"] != nil 
        date = Date.strptime(row["Rcpt_Date"], '%Y%m%d')
        t.transaction_date = date
    end
    t.amount = row["Amount"]
    t.expense_code = row["Expn_Code"]
    t.unique_key = "#{row["Filer_ID"]} #{row["Tran_ID"]}"
    t.save
    if t.transaction_type == "RCPT"
      t.add_to_contributor
    end
    if t.transaction_type == "EXPN"
      t.add_to_vendor
    end
    t.generate_full_name
  end
# City Expenditures Spreadsheet
  header = expenditures.row(1)
    (2..expenditures.last_row).each do |i|
      row = Hash[[header, expenditures.row(i)].transpose]
      t = Transaction.new
      t.candidate_committee_id = candidate_committee.id
      t.import_id = import.id
      t.transaction_type = row['Rec_Type'] 
      t.entity_type = row["Entity_Cd"]
      t.entity_last_name = row["Payee_NamL"]
      t.entity_first_name = row["Payee_NamF"]
      t.entity_city = row["Payee_City"]
      t.entity_state = row["Payee_ST"]
      t.entity_zip = row["Payee_ZIP4"]

      t.description = row["Expn_Dscr"]
      if row["Expn_Date"] != nil 
          date = Date.strptime(row["Expn_Date"], '%Y%m%d')
          t.transaction_date = date
      end
      t.amount = row["Amount"]
      t.expense_code = row["Expn_Code"]
      t.unique_key = "#{row["Filer_ID"]} #{row["Tran_ID"]}"
      t.save
      if t.transaction_type == "RCPT"
        t.add_to_contributor
      end
      if t.transaction_type == "EXPN"
        t.add_to_vendor
      end
      t.generate_full_name
    end

   
  elsif spreadsheet.cell(1,7) == "EMPLOYER"
    # State Contributions
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      t = Transaction.new
      t.candidate_committee_id = candidate_committee.id
      t.import_id = import.id
      t.transaction_type = "RCPT"
      t.payment_type = row["PAYMENT TYPE"]
      
     
      t.entity_first_name = row["NAME OF CONTRIBUTOR"]
      if row["CITY"] != nil
        t.entity_city = row["CITY"].titlecase
      end
      t.entity_state = row["STATE"]
      t.entity_zip = row["ZIP"]
      if row["OCCUPATION"] != nil 
        if row["EMPLOYER"] != nil
          t.entity_employer = row["EMPLOYER"].titlecase
        end
      t.entity_occupation = row["OCCUPATION"].titlecase
      end
      if t.entity_occupation != nil
        t.entity_type = "IND"
        t.entity_first_name = row["NAME OF CONTRIBUTOR"].titlecase
      else
        t.entity_first_name = row["NAME OF CONTRIBUTOR"]
      end
      t.description = row["Description"]
      if row["TRANSACTION DATE"] != nil 
        t.transaction_date = row["TRANSACTION DATE"]
      end
      t.amount = row["AMOUNT"]
      t.expense_code = row["Expn_Code"]
      t.unique_key = row["TRANSACTION NUMBER"]
      t.save
      if t.transaction_type == "RCPT"
        t.add_to_contributor
      end
      if t.transaction_type == "EXPN"
        t.add_to_vendor
      end
      t.generate_full_name
    end

  elsif spreadsheet.cell(1,3) == "EXPENDITURE CODE"
    # State Expenditures
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      t = Transaction.new
      t.candidate_committee_id = candidate_committee.id
      t.import_id = import.id
      t.transaction_type = "EXPN"

      
     
      t.entity_first_name = row["PAYEE"].titlecase
      
      t.entity_state = row["STATE"]
      t.entity_zip = row["ZIP"]
   
      
      t.description = row["DESCRIPTION"]
      if row["DATE"] != nil 
        t.transaction_date = row["DATE"]
      end
      t.amount = row["AMOUNT"]
      t.expense_code = row["EXPENDITURE CODE"]
      t.unique_key = "#{row["DATE"]}#{row["PAYEE"]}#{row["EXPENDITURE CODE"]}#{row["DESCRIPTION"]}#{row["AMOUNT"]}"
      t.save

      if t.transaction_type == "EXPN"
        t.add_to_vendor
      end
      t.generate_full_name
    end

  elsif spreadsheet.cell(1,3) == "CONTEST"
    # State Expenditures
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      t = Transaction.new
      t.candidate_committee_id = candidate_committee.id
      t.import_id = import.id
      t.transaction_type = "CTB"

      
     
      t.entity_first_name = row["PAYEE"].titlecase
      

   
      

      if row["DATE"] != nil 
        t.transaction_date = row["DATE"]
      end
      t.amount = row["AMOUNT"]
      
      t.unique_key = "#{row["DATE"]}#{row["PAYEE"]}#{row["AMOUNT"]}"
      t.save

      t.generate_full_name
    end

  end

end

def generate_full_name
  entity_full_name = "#{entity_first_name} #{entity_last_name}"
  update_attributes(full_name: entity_full_name.strip)
end

def self.import_expenditures(monetary_expenditures)
  import = Import.new
    import.candidate_committee_id = candidate_committee.id
    import.save
  
  end  

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def add_to_contributor
    entity_full_name = "#{entity_first_name} #{entity_last_name}"
      if Contributor.where(:full_name => entity_full_name).exists? 
        Contributor.all.each do |c|
          if entity_full_name == c.full_name
            update_attributes(contributor_id: c.id)
          end
        end
      else
        contributor = Contributor.create!
        contributor.update_attributes(first_name: entity_first_name)
        contributor.update_attributes(last_name: entity_last_name)
        contributor.update_attributes(full_name: "#{contributor.first_name} #{contributor.last_name}")
        update_attributes(contributor_id: contributor.id)
      end 
    end

    def add_to_vendor
        entity_full_name = "#{entity_first_name} #{entity_last_name}"
        trimmed_full_name = entity_full_name.strip
        if Vendor.where(:full_name => trimmed_full_name).exists? 
          Vendor.all.each do |c|
            if trimmed_full_name == c.full_name
              update_attributes(vendor_id: c.id)
            end
          end
        else
          vendor = Vendor.create!
          vendor.update_attributes(first_name: entity_first_name)
          vendor.update_attributes(last_name: entity_last_name)
          vendor.update_attributes(full_name: "#{vendor.first_name} #{vendor.last_name}".strip)
          update_attributes(vendor_id: vendor.id)
        end
      
     
  end

def set_individual
  if entity_occupation != nil
    update_attributes(entity_type: "IND")
  elsif entity_occupation == nil
    update_attributes(entity_type: "")
  end
end

  def full_expense_type
  if expense_code == "CMP"
    "Campaign Paraphernalia/Misc"
  elsif expense_code == "CNS"
    "Campaign Consultants"
  elsif expense_code == "CTB"
    "Contribution"
  elsif expense_code == "CVC"
    "Civic Donations"
  elsif expense_code == "FIL"
    "Candidate Filing/Ballot Fees"
  elsif expense_code == "FND"
    "Fundraising Costs"
  elsif expense_code == "IND"
    "Independent Expenditure"
  elsif expense_code == "LEG"
    "Legal Defense"
  elsif expense_code == "LIT"
    "Campaign Literature & Mailings"
  elsif expense_code == "MBR"
    "Member Communications"
  elsif expense_code == "MTG"
    "Meetings & Appearances"
  elsif expense_code == "OFC"
    "Office Expenses"
  elsif expense_code == "PET"
    "Petition Circulating"
  elsif expense_code == "PHO"
    "Phone Banks"
  elsif expense_code == "POL"
    "Polling & Survey Research"
  elsif expense_code == "POS"
    "Postage, Delivery, and Messenger Services"
  elsif expense_code == "PRO"
    "Professional Services (Legal, Accounting)"
  elsif expense_code == "PRT"
    "Print Ads"
  elsif expense_code == "RAD"
    "Radio Airtime & Production Costs"
  elsif expense_code == "RFD"
    "Returned Contributions"
  elsif expense_code == "SAL"
    "Campaign Workers' Salaries"
  elsif expense_code == "TEL"
    "TV or Cable Airtime and Production Costs"
  elsif expense_code == "TRC"
    "Candidate Travel, Lodging, and Meals"
  elsif expense_code == "TRS"
    "Staff/Spouse Travel, Lodging, and Meals"
  elsif expense_code == "TSF"
    "Transfer Between Committees of Same Candidate/Sponsor"
  elsif expense_code == "VOT"
    "Voter Registration"
  elsif expense_code == "WEB"
    "IT Costs (Internet, Email"
  elsif expense_code == ""
    "Unidentified"
  else
    if expense_code != nil
    expense_code.titlecase
    else
      "Unidentified"
    end
  end
end






    


end
