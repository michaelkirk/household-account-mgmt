class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.decimal :amount, :precision => 8, :scale => 2, :null => false
      t.boolean :credit, :null => false
      t.string :message
      t.integer :household_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
