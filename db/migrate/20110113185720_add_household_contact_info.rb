class AddHouseholdContactInfo < ActiveRecord::Migration
  def self.up
    add_column :households, :phone1, :string
    add_column :households, :phone2, :string
 
    add_column :households, :address1, :string
    add_column :households, :address2, :string
    add_column :households, :city, :string
    add_column :households, :state, :string
    add_column :households, :zip, :string
    
    add_column :households, :notes, :text
  
  end

  def self.down
    remove_column :households, :phone1
    remove_column :households, :phone2
    
    remove_column :households, :address1
    remove_column :households, :address2
    remove_column :households, :city
    remove_column :households, :state
    remove_column :households, :zip
    
    remove_column :households, :notes
    
  end
end
