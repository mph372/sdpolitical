desc "Updating birth dates from date of birth"
task :update_birth_date_fields => :environment do
  puts "Updating birth dates from date of birth"
  
  Person.where('birthdate is not null').each do |u|
    u.birth_month = u.birthdate.month
    u.birth_day = u.birthdate.day
    u.save
  end

  puts "Finished updating birth dates from date of birth"
end