# Preview all emails at http://localhost:3000/rails/mailers/expenditure_mailer
class ExpenditureMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/expenditure_mailer/tracked_expenditure
  def tracked_expenditure
    ExpenditureMailer.with(expenditure: Expenditure.last, user: User.first).tracked_expenditure
  end

end
