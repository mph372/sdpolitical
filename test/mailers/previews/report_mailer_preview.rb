# Preview all emails at http://localhost:3000/rails/mailers/report_mailer
class ReportMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/report_mailer/tracked_report
  def tracked_report
    ReportMailer.with(report: Report.find(23), user: User.first).tracked_report
  end




end
