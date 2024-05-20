namespace :reports do
  desc "Send weekly a vehicle report and people report"
  task send_weekly_report: :environment do
    Report.email_report
  end
end
