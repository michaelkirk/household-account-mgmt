class DropHouseholdContactInfo < ActiveRecord::Migration
  def change
    remove_column :households, :phone1
    remove_column :households, :phone2

    remove_column :households, :address1
    remove_column :households, :address2
    remove_column :households, :city
    remove_column :households, :state
    remove_column :households, :zip
  end
end
