class RegistrationSnapshot < ApplicationRecord
  belongs_to :statistical_datum
  delegate :district, to: :statistical_datum

  def self.import(file)
    spreadsheet = open_spreadsheet(file) # open spreadsheet
    header = spreadsheet.row(1) # get header row
    # County Master Spreadsheet
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      t = RegistrationSnapshot.new
      t.snapshot_date = DateTime.now
      t.total_registered = row['Total'] 
      t.registered_dem = row['Dem'] 
      t.registered_rep = row['Rep'] 
      t.registered_other = row['Other (Not DEM or REP)'] 
      t.statistical_datum_id = row['Statistical Datum'] 
      if t.statistical_datum_id != nil
        t.save
      end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
    when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def democrat_percentage
    (registered_dem.to_f / total_registered) * 100
  end

  def republican_percentage
    (registered_rep.to_f / total_registered) * 100
  end

  def other_percentage
    ((total_registered - (registered_rep.to_f + registered_dem.to_f)) / total_registered) * 100
  end

  def registration_advantage
    democrat_percentage - republican_percentage
  end

  def absolute_registration_advantage
    registration_advantage*-1
  end

  def display_registration_advantage
    if registration_advantage > 0 
      "D +#{ActionController::Base.helpers.number_with_precision(registration_advantage.abs, precision: 2)}"
    else
      "R +#{ActionController::Base.helpers.number_with_precision(registration_advantage.abs, precision: 2)}"
    end
  end
end
