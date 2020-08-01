desc "Updating districts for incumbents seeking re-election"
task :update_district_field => :environment do
  puts "Updating..."
  
  Person.where('running_reelection = ? AND is_incumbent = ?', true, true).each do |u|
    u.district = u.incumbent_district
    u.save
  end

  Person.where('running_reelection = ? AND is_incumbent = ? AND on_ballot = ?', false, true, false).each do |u|
    u.district = nil
    u.save
  end

  puts "Finished updating"
end

