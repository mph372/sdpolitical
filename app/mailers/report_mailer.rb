class ReportMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.tracked_report.subject
  #
  def tracked_report
    @user = params[:user]
    @report = params[:report]

    mail to: "#{@user.email}", subject: "New Campaign Finance Report for #{@report.person.full_name}"
  end
end
