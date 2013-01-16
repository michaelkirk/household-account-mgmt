class AddVoidToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :void, :boolean, :default => false
  end
end
