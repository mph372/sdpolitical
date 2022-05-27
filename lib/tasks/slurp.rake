namespace :slurp do
  desc "TODO"
  task transactions: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("lib", "csvs", "desmond.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      t = CountyTransaction.new
      t.rec_type = row["Rec_Type"] 
      t.entity_cd = row ["Entity_Cd"]
      t.entity_name_last = row["Entity_Nam L"]
      t.entity_name_first = row["Entity_Nam F"]
      t.entity_city = row["Entity_City"]
      t.entity_st = row["Entity_ST"]
      t.entity_zip4 = row["Entity_ZIP4"]
      t.entity_emp = row["Entity_Emp"]
      t.entity_occ = row["Entity_Occ"]
      t.amount = row["Amount"]
      t.expn_code = row["Expn_Code"]
      t.save
    end

    puts "There are now #{CountyTransaction.count} rows in the transactions table"

  end

end
