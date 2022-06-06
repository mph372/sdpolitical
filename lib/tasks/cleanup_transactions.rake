desc "De-Dupes and Removes Contributors & Vendors"
task :cleanup_transactions => :environment do
  puts "Cleaning database..."
  

  
  Contributor.all.each do |contributor|
    contributor.contributor_merge
    contributor.contributor_cleanup
  end

  Vendor.all.each do |vendor|
    vendor.vendor_merge
    vendor.vendor_cleanup
  end
  

  puts "Finished cleaning database..."
end