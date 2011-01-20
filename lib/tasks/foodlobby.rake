namespace :foodlobby do
  class FMMember
    @@households = []
  end
  
  desc "import members from csv"
  task :import => :environment do
    filename = 'db/members.csv' 
    puts "importing members from file #{filename}"
    require 'csv'    

    member_rows= []
    CSV::Reader.parse(File.open(filename)) do |row|
      member_rows << row
    end
    
    member_rows=member_rows[1..-1]

    member_rows.each do |row|
      Member.create!(:id=>row[0], 
                     :active=> (row[1]=='no' ? true : false), 
                     :first_name => row[4], 
                     :last_name => row[5], 
                     :created_at=> DateTime.parse(row[6]), 
                     :household_id=> row[7], 
                     :email=>row[8], 
                     :phone1=> row[9], 
                     :phone2=> row[10], 
                     :address1=> row[11], 
                     :city=> row[12], 
                     :state=> row[13], 
                     :zip=> row[14])
    end

  end
end

