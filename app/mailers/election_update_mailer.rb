class ElectionUpdateMailer < ApplicationMailer
  def new_update_notification(user, election_update)
    @user = user
    @election = election_update.election
    @election_update = election_update
    
    mail(
      to: user.email,
      subject: "New Election Update for #{@election.name}"
    )
  end
end