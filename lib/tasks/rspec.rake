namespace :db do
  namespace :schema do
    desc "augment default test:prepare to load our db views"
    task :load do
      # manually re-run the migration which creates our view, since it's not kep in the schema.rb
      load 'db/migrate/20111113205046_create_monthly_reports.rb'
      CreateMonthlyReports.new.up
    end
  end
end
