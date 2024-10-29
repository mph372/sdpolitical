# app/jobs/election_update_notification_job.rb
class ElectionUpdateNotificationJob < ApplicationJob
  queue_as :default

  def perform(election_update_id)
    election_update = ElectionUpdate.find(election_update_id)
    eligible_users = User.where("created_at >= ?", Date.new(2024, 1, 1))
                        .where(notify_when_new_report: true)
                        .where.not(confirmed_at: nil)

    eligible_users.find_each do |user|
      ElectionUpdateMailer.with(user: user, election_update: election_update)
                         .new_update_notification
                         .deliver_later(wait: 5.seconds)
    end
  end
end