class Transaction < ApplicationRecord
  belongs_to :candidate_committee, optional: :true 
  belongs_to :import, optional: :true 
  belongs_to :contributor, optional: :true
  belongs_to :vendor, optional: :true
  validates :unique_key, uniqueness: true
  validate :exclude_actblue
  validate :require_amount

  def exclude_actblue
    if organization_name != nil && organization_name.downcase.similar("Act Blue".downcase) > 90
      errors.add(:organization_name, "Cannot be ActBlue")
    end
  end

  def require_amount
    if amount == nil 
      errors.add(:amount, "Amount Required")
    end
  end
  
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
      t.payment_type = row['Form_Type']
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
      t.unique_key = "#{row["Filer_ID"]} #{row["Filer_Nam L"].downcase} #{row["Tran_ID"]}"
      t.save
      t.generate_full_name
      if t.transaction_type == "RCPT"
        t.add_to_contributor
      end
      if t.transaction_type == "EXPN"
        t.add_to_vendor
        t.convert_expense_code
      end
      
    end
      
  elsif spreadsheet.cell(1,15) == "Tran_NamL"

    cv_contributions = spreadsheet.sheet_for("A-Contributions")
    cv_expenditures = spreadsheet.sheet_for("E-Expenditure")
    cv_nonmonetary = spreadsheet.sheet_for("C-Contributions")
    cv_loans = spreadsheet.sheet_for("B1-Loans")
  # CV City Contributions Spreadsheet
  header = cv_contributions.row(1)
  (2..cv_contributions.last_row).each do |i|
    row = Hash[[header, cv_contributions.row(i)].transpose]
    t = Transaction.new
    t.candidate_committee_id = candidate_committee.id
    t.import_id = import.id
    t.payment_type = row['Form_Type'] 
    t.transaction_type = row['Rec_Type'] 
    t.entity_type = row["Entity_Cd"]
    t.entity_last_name = row["Tran_NamL"]
    t.entity_first_name = row["Tran_NamF"]
    t.entity_city = row["Tran_City"]
    t.entity_state = row["Tran_State"]
    t.entity_zip = row["Tran_ZIP4"]
    t.entity_employer = row["Tran_Emp"]
    t.entity_occupation = row["Tran_Occ"]
    t.description = row["Tran_Dscr"]
    if row["Tran_Date"] != nil 
       
        t.transaction_date = row["Tran_Date"]
    end
    t.amount = row["Tran_Amt1"]
    t.expense_code = row["Expn_Code"]
    t.unique_key = "#{row["Filer_ID"]} #{row["Filer_NamL"].downcase} #{row["Tran_ID"]}"
    t.save
    t.generate_full_name
    if t.transaction_type == "RCPT"
      t.add_to_contributor
    end
    if t.transaction_type == "EXPN"
      t.add_to_vendor
    end
    
  end
  #CV Non-Monetary Contributions
  header = cv_nonmonetary.row(1)
  (2..cv_nonmonetary.last_row).each do |i|
    row = Hash[[header, cv_nonmonetary.row(i)].transpose]
    t = Transaction.new
    t.candidate_committee_id = candidate_committee.id
    t.import_id = import.id
    t.payment_type = row['Form_Type'] 
    t.transaction_type = row['Rec_Type'] 
    t.entity_type = row["Entity_Cd"]
    t.entity_last_name = row["Tran_NamL"]
    t.entity_first_name = row["Tran_NamF"]
    t.entity_city = row["Tran_City"]
    t.entity_state = row["Tran_ST"]
    t.entity_zip = row["Tran_ZIP4"]
    t.entity_employer = row["Tran_Emp"]
    t.entity_occupation = row["Tran_Occ"]
    t.description = row["Tran_Dscr"]
    if row["Tran_Date"] != nil 
        t.transaction_date = row["Tran_Date"]
    end
    t.amount = row["Tran_Amt1"]
    t.expense_code = row["Expn_Code"]
    t.unique_key = "#{row["Filer_ID"]} #{row["Filer_NamL"].downcase} #{row["Tran_ID"]}"
    t.save
    t.generate_full_name
    if t.transaction_type == "RCPT"
      t.add_to_contributor
    end
    if t.transaction_type == "EXPN"
      t.add_to_vendor
    end
    
  end

    #Chula Vista Expenditures
    header = cv_expenditures.row(1)
    (2..cv_expenditures.last_row).each do |i|
      row = Hash[[header, cv_expenditures.row(i)].transpose]
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
        t.transaction_date = row["Expn_Date"]
      end
      t.amount = row["Amount"]
      t.expense_code = row["Expn_Code"]
      t.unique_key = "#{row["Filer_ID"]} #{row["Filer_NamL"].downcase} #{row["Tran_ID"]}"
      t.save
      t.generate_full_name
      if t.transaction_type == "RCPT"
        t.add_to_contributor
      end
      if t.transaction_type == "EXPN"
        t.add_to_vendor
      end
      
      t.convert_expense_code
    end

        #Chula Vista Loans
        header = cv_loans.row(1)
        (2..cv_loans.last_row).each do |i|
          row = Hash[[header, cv_loans.row(i)].transpose]
          t = Transaction.new
          t.candidate_committee_id = candidate_committee.id
          t.import_id = import.id
          t.transaction_type = row['Rec_Type'] 
          t.entity_type = row["Entity_Cd"]
          t.entity_last_name = row["Lndr_NamL"]
          t.entity_first_name = row["Lndr_NamF"]
          t.entity_city = row["Loan_City"]
          t.entity_state = row["Loan_ST"]
          t.entity_zip = row["Loan_ZIP4"]
    
          t.description = row["Expn_Dscr"]
          if row["Loan_Date1"] != nil 
            t.transaction_date = row["Loan_Date1"]
          end
          t.amount = row["Loan_Amt1"]
          t.expense_code = row["Expn_Code"]
          t.unique_key = "#{row["Filer_ID"]} #{row["Loan_Amt1"]} #{row["Tran_ID"]}"
          if row["Loan_Amt1"] != 0.00
          t.save
          end
          t.generate_full_name
          if t.transaction_type == "RCPT"
            t.add_to_contributor
          end
          if t.transaction_type == "EXPN"
            t.add_to_vendor
          end
         
        end

  elsif spreadsheet.cell(1,15) == "Ctrib_NamL"
    sd_contributions = spreadsheet.sheet_for("F460-A-Contribs")
    sd_expenditures = spreadsheet.sheet_for("F460-E-Expenditures")
    sd_nonmonetary = spreadsheet.sheet_for("F460-C-Contribs")
    sd_loans = spreadsheet.sheet_for("F460-B1-Loans")
    # SD City Contributions Spreadsheet
  header = sd_contributions.row(1)
  (2..sd_contributions.last_row).each do |i|
    row = Hash[[header, sd_contributions.row(i)].transpose]
    t = Transaction.new
    t.candidate_committee_id = candidate_committee.id
    t.import_id = import.id
    t.payment_type = row['Form_Type'] 
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
    t.unique_key = "#{row["Filer_ID"]} #{row["Filer_NamL"].downcase} #{row["Tran_ID"]}"
    t.save
    t.generate_full_name
    if t.transaction_type == "RCPT"
      t.add_to_contributor
    end
    if t.transaction_type == "EXPN"
      t.add_to_vendor
    end
    
  end
  #SD Non-Monetary Contributions
  header = sd_nonmonetary.row(1)
  (2..sd_nonmonetary.last_row).each do |i|
    row = Hash[[header, sd_nonmonetary.row(i)].transpose]
    t = Transaction.new
    t.candidate_committee_id = candidate_committee.id
    t.import_id = import.id
    t.payment_type = row['Form_Type'] 
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
    t.unique_key = "#{row["Filer_ID"]} #{row["Filer_NamL"].downcase} #{row["Tran_ID"]}"
    t.save
    t.generate_full_name
    if t.transaction_type == "RCPT"
      t.add_to_contributor
    end
    if t.transaction_type == "EXPN"
      t.add_to_vendor
    end
    
  end
    # SD City Expenditures Spreadsheet
  header = sd_expenditures.row(1)
  (2..sd_expenditures.last_row).each do |i|
    row = Hash[[header, sd_expenditures.row(i)].transpose]
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
      t.transaction_date = row["Expn_Date"]
    end
    t.amount = row["Amount"]
    t.expense_code = row["Expn_Code"]
    t.unique_key = "#{row["Filer_ID"]} #{row["Filer_NamL"].downcase} #{row["Tran_ID"]}"
    t.save
    t.generate_full_name
    if t.transaction_type == "RCPT"
      t.add_to_contributor
    end
    if t.transaction_type == "EXPN"
      t.add_to_vendor
    end
    
    t.convert_expense_code
  end

  #City of SD Loans
  header = sd_loans.row(1)
  (2..sd_loans.last_row).each do |i|
    row = Hash[[header, sd_loans.row(i)].transpose]
    t = Transaction.new
    t.candidate_committee_id = candidate_committee.id
    t.import_id = import.id
    t.transaction_type = row['Rec_Type'] 
    t.entity_type = row["Entity_Cd"]
    t.entity_last_name = row["Lndr_NamL"]
    t.entity_first_name = row["Lndr_NamF"]
    t.entity_city = row["Loan_City"]
    t.entity_state = row["Loan_ST"]
    t.entity_zip = row["Loan_ZIP4"]

    t.description = row["Expn_Dscr"]
    if row["Loan_Date1"] != nil 
      t.transaction_date = row["Loan_Date1"]
    end
    t.amount = row["Loan_Amt1"]
    t.expense_code = row["Expn_Code"]
    t.unique_key = "#{row["Filer_ID"]} #{row["Loan_Amt1"]} #{row["Tran_ID"]}"
    if row["Loan_Amt1"] != 0.00
    t.save
    end
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
      t.set_individual
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
      t.convert_expense_code
    end

  elsif spreadsheet.cell(1,3) == "TRANSACTION ID"
    fed_contributions = spreadsheet.sheet_for("Schedule A")
    fed_expenditures = spreadsheet.sheet_for("Schedule B")
    fed_loans = spreadsheet.sheet_for("Schedule C")
    # Federal Contributions
    (2..fed_contributions.last_row).each do |i|
      row = Hash[[header, fed_contributions.row(i)].transpose]
      t = Transaction.new
      t.candidate_committee_id = candidate_committee.id
      t.import_id = import.id
      t.transaction_type = "RCPT"
      t.payment_type = "Monetary"
      t.entity_type = row['ENTITY TYPE']
      t.organization_name = row['CONTRIBUTOR ORGANIZATION NAME']
      t.entity_first_name = row["CONTRIBUTOR FIRST NAME"]
      t.entity_last_name = row["CONTRIBUTOR LAST NAME"]
      if row["CONTRIBUTOR CITY"] != nil
        t.entity_city = row["CONTRIBUTOR CITY"].titlecase
      end
      t.entity_state = row["CONTRIBUTOR STATE"]
      if row["CONTRIBUTOR ZIP"] != nil
        zip = row["CONTRIBUTOR ZIP"]
        t.entity_zip = zip
      end
      
      if row["CONTRIBUTOR OCCUPATION"] != nil 
        if row["CONTRIBUTOR EMPLOYER"] != nil
          t.entity_employer = row["CONTRIBUTOR EMPLOYER"].titlecase
        end
      t.entity_occupation = row["CONTRIBUTOR OCCUPATION"].titlecase
      end
      
      t.description = row["CONTRIBUTION PURPOSE DESCRIP"]
      if row["CONTRIBUTION DATE"] != nil 
        t.transaction_date = row["CONTRIBUTION DATE"]
      end
      t.amount = row["CONTRIBUTION AMOUNT {F3L Bundled}"]
      t.expense_code = row["Expn_Code"]
      t.unique_key = "#{row["FILER COMMITTEE ID NUMBER"]} #{row['TRANSACTION ID']}"
   
      t.save
 
      t.generate_full_name
      if t.transaction_type == "RCPT"
        t.add_to_contributor
      end
    end
    #Federal Expenditures
    (2..fed_expenditures.last_row).each do |i|
      row = Hash[[header, fed_expenditures.row(i)].transpose]
      t = Transaction.new
      t.candidate_committee_id = candidate_committee.id
      t.import_id = import.id
      t.transaction_type = "EXPN"
      t.payment_type = "Monetary"
      t.organization_name = row['PAYEE ORGANIZATION NAME']
     
      t.entity_first_name = row["PAYEE FIRST NAME"]
      t.entity_last_name = row["PAYEE LAST NAME"]
      if row["PAYEE CITY"] != nil
        t.entity_city = row["PAYEE CITY"].titlecase
      end
      t.entity_state = row["PAYEE STATE"]
      if row["PAYEE ZIP"] != nil
        zip = row["PAYEE ZIP"]
        t.entity_zip = zip[0,5]
      end
      
      if row["CONTRIBUTOR OCCUPATION"] != nil 
        if row["CONTRIBUTOR EMPLOYER"] != nil
          t.entity_employer = row["CONTRIBUTOR EMPLOYER"].titlecase
        end
      t.entity_occupation = row["CONTRIBUTOR OCCUPATION"].titlecase
      end
      
      t.description = row["CONTRIBUTION PURPOSE DESCRIP"]
      if row["EXPENDITURE DATE"] != nil 
        t.transaction_date = row["EXPENDITURE DATE"]
      end
      t.amount = row["EXPENDITURE AMOUNT {F3L Bundled}"]
      t.expense_code = row["EXPENDITURE PURPOSE DESCRIP"]
      t.unique_key = "#{row["FILER COMMITTEE ID NUMBER"]} #{row['PAYEE ZIP']} #{row["EXPENDITURE DATE"]} #{row['EXPENDITURE AMOUNT {F3L Bundled}']}"
      t.save
      t.generate_full_name
      if t.transaction_type == "EXPN"
        t.add_to_vendor
      end

    end

    (2..fed_loans.last_row).each do |i|
      row = header.zip(fed_loans.row(i)).to_h
      t = Transaction.new
      t.candidate_committee_id = candidate_committee.id
      t.import_id = import.id
      t.transaction_type = "LOAN"
      
      
      t.organization_name = row['LENDER ORGANIZATION NAME']
      t.entity_first_name = row["LENDER FIRST NAME"]
      t.entity_last_name = row["LENDER LAST NAME"]
      if row["LENDER CITY"] != nil
        t.entity_city = row["LENDER CITY"].titlecase
      end
      t.entity_state = row["LENDER STATE"]
      if row["LENDER ZIP"] != nil
        zip = row["LENDER ZIP"]
        t.entity_zip = zip[0,5]
      end
      

      
     
      if row["LOAN INCURRED DATE (Terms)"] != nil 
        t.transaction_date = row["LOAN INCURRED DATE (Terms)"]
      end
      t.amount = row["LOAN AMOUNT (Original)"]

      t.unique_key = "#{row["FILER COMMITTEE ID NUMBER"]} #{row['TRANSACTION ID NUMBER']}"
      t.save
      t.generate_full_name
    end

  end

end



def full_payment_type
  if payment_type == "A"
    "Monetary"
  elsif payment_type == "C"
    "Non-Monetary"
  elsif transaction_type == "LOAN"
    "Loan"
  elsif payment_type != nil
    payment_type.titlecase
  end
end

def generate_full_name
  if organization_name != nil 
    update_attributes(full_name: organization_name.titlecase.strip)
  else
  entity_full_name = "#{entity_first_name} #{entity_last_name}"
  update_attributes(full_name: entity_full_name.titlecase.strip)
  end
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
      if Contributor.where(:full_name => full_name).exists? 
        Contributor.all.each do |c|
          if full_name == c.full_name
            update_attributes(contributor_id: c.id)
          end
        end
      else
        contributor = Contributor.create!
        contributor.update_attributes(first_name: entity_first_name)
        contributor.update_attributes(last_name: entity_last_name)
        contributor.update_attributes(full_name: full_name.titlecase)
        update_attributes(contributor_id: contributor.id)
      end 
    end

    def add_to_vendor
        if Vendor.where(:full_name => full_name).exists? 
          Vendor.all.each do |c|
            if full_name == c.full_name
              update_attributes(vendor_id: c.id)
            end
          end
        else
          vendor = Vendor.create!
          vendor.update_attributes(first_name: entity_first_name)
          vendor.update_attributes(last_name: entity_last_name)
          vendor.update_attributes(full_name: full_name.titlecase)
          update_attributes(vendor_id: vendor.id)
        end
      
     
  end

def set_individual
  if entity_occupation == nil || entity_occupation == "N/A"
    update_attributes(entity_type: "")
  elsif entity_occupation != nil 
      update_attributes(entity_type: "IND")
  end
end

def convert_expense_code
  if expense_code == nil || expense_code == ""
    update_attributes(expense_code: description)
  end
end

def full_transaction_type
  if transaction_type == "RCPT"
    "Contribution"
  elsif transaction_type == "LOAN"
    "Loan"
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
    end
  end
end

def display_name
  if organization_name != nil
    organization_name.titlecase
  else
    full_name.titlecase
  end
end




    


end
