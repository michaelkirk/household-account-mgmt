class AddVoidToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :void, :boolean 
  end
end
