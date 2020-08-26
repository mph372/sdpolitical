class EmailsController < ApplicationController
  def unsubscribe
    user = User.find_by_unsubscribe_hash(params[:unsubscribe_hash])

    case params[:subscription]
    when "tracked_expenditure"
      @reason = "new expenditures"
      user.update(notify_when_new_expenditure: false)
    when "tracked_report"
      @reason = "new reports"
      user.update(notify_when_new_report: false)
    end
  end
end
