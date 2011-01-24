namespace :foodlobby do

  desc "import members from csv"
  task :import => :environment do
    filename = 'db/members.csv' 
    puts "importing members from file #{filename}"
    require 'csv'    

    member_rows= []
    CSV::Reader.parse(File.open(filename)) do |row|
      member_rows << row
    end
    
    # remove first row, which contains column names, not actual data
    member_rows=member_rows[1..-1]

    #create a member for each row
    member_rows.each do |row|

      legacy_fm_id= row[7]#household id from legacy filemaker db
      if( legacy_fm_id== '0') #not in a household in the legacy db
        household = Household.create! # the member will be in their own household
      else
        household = Household.find_or_create_by_fm_id(legacy_fm_id)
      end

      Member.create!(:fm_id=>row[0], 
                     :active=> (row[1]=='no' ? true : false), 
                     :first_name => row[4], 
                     :last_name => row[5], 
                     :created_at=> DateTime.parse(row[6]), 
                     :household => household,
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

