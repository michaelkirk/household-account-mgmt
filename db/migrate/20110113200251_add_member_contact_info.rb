class AddMemberContactInfo < ActiveRecord::Migration
  def self.up
    add_column :members, :phone1, :string
    add_column :members, :phone2, :string
 
    add_column :members, :address1, :string
    add_column :members, :address2, :string
    add_column :members, :city, :string
    add_column :members, :state, :string
    add_column :members, :zip, :string
    
    add_column :members, :notes, :text
  
  end

  def self.down
    remove_column :members, :phone1
    remove_column :members, :phone2
    
    remove_column :members, :address1
    remove_column :members, :address2
    remove_column :members, :city
    remove_column :members, :state
    remove_column :members, :zip
    
    remove_column :members, :notes
    
  end
end
