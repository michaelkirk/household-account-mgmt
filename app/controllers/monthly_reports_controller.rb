class MonthlyReportsController < ApplicationController
  def index
    @monthly_reports = MonthlyReport.all
  end
end