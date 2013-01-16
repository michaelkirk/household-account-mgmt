class ExcludeVoidsFromMonthlyReports < ActiveRecord::Migration
  def up
    sql = <<-SQL
      create view monthly_reports as
        select date_part('year', created_at) as year, date_part('month', created_at) as month, sum(purchase_amount) as purchases_amount, sum(investment_amount) as investments_amount
          from (
            select * from transactions
              left join
                (select id as purchase_id, amount as purchase_amount from transactions where credit = false)
                as purchases on transactions.id = purchases.purchase_id
              left join
                (select id as investment_id, amount as investment_amount from transactions where credit = true)
                as investments on transactions.id = investments.investment_id)
              as classified_transactions
              where classified_transactions.void = false
          group by year, month
          order by year, month
    SQL

    execute(sql)
  end

  def down
    sql = <<-SQL
      create view monthly_reports as
        select date_part('year', created_at) as year, date_part('month', created_at) as month, sum(purchase_amount) as purchases_amount, sum(investment_amount) as investments_amount
          from (
            select * from transactions
              left join
                (select id as purchase_id, amount as purchase_amount from transactions where credit = false)
                as purchases on transactions.id = purchases.purchase_id
              left join
                (select id as investment_id, amount as investment_amount from transactions where credit = true)
                as investments on transactions.id = investments.investment_id)
              as classified_transactions
          group by year, month
          order by year, month
    SQL

    execute(sql)
  end

end
