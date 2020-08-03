class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :dashboardable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :districts 
  acts_as_follower
  
  def subscribed?
    stripe_subscription_id?
  end

  def full_name
    first_name + " " + last_name
  end

  def user_confirmed
    if self.confirmed_at.present?
      return true
    end
  end

  after_create :subscribe_user_to_mailing_list


  private

  def subscribe_user_to_mailing_list
    SubscribeUserToMailingListJob.perform_later(self)
  end

end
