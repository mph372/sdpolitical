class EmailsController < ApplicationController
  def unsubscribe
    user = User.find_by_unsubscribe_hash(params[:unsubscribe_hash])
    user.update(notify_when_new_expenditure: false)
  end
end
