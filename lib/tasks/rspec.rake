namespace :db do
  namespace :schema do
    desc "augment default test:prepare to load our db views"
    task :load do
      # manually re-run the migration which creates our view, since it's not kep in the schema.rb
      load 'db/migrate/20130115205046_exclude_voids_from_monthly_reports.rb'
      ExcludeVoidsFromMonthlyReports.new.up
    end
  end
end
