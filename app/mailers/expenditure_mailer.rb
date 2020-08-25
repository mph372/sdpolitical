class ExpenditureMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.expenditure_mailer.tracked_expenditure.subject
  #
  def tracked_expenditure
    @user = params[:user]
    @expenditure = params[:expenditure]

    mail to: "#{@user.email}", subject: "New Expenditure in #{@expenditure.person.district.jurisdiction.name} - #{@expenditure.person.district.district_name}"
  end
end
