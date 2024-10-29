class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :dashboardable and :omniauthable
  before_create :add_unsubscribe_hash
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable


  
  def subscribed?
    stripe_subscription_id? || free_account?
  end


  def full_name
    first_name + " " + last_name
  end

  def user_confirmed
    if self.confirmed_at.present?
      return true
    end
  end

  def admin_mode
   Admin.last.admin_mode == true 
  end

  # after_create :subscribe_user_to_mailing_list


  private

  def subscribe_user_to_mailing_list
    SubscribeUserToMailingListJob.perform_later(self)
  end

  private

  def add_unsubscribe_hash
    self.unsubscribe_hash = SecureRandom.hex
  end

end
