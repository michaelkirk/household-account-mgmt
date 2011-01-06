class Transaction < ActiveRecord::Base
  belongs_to :household

  validates_inclusion_of :credit, :in => [true, false]
  validates_presence_of :household_id
  validates_presence_of :amount
  validates_numericality_of :amount
  
end