class MonthlyReport < ActiveRecord::Base
  MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

  def time_period
    "#{month} #{year}"
  end

  def month
    MONTHS[self[:month] - 1]
  end

  def year
    self[:year].to_i
  end

end
