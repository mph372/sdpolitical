class User < ApplicationRecord
  has_many :pinned_contests, dependent: :destroy
  has_many :pinned_election_contests, through: :pinned_contests, source: :contest
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :dashboardable and :omniauthable
  before_create :add_unsubscribe_hash
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  
  
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

  def add_unsubscribe_hash
    self.unsubscribe_hash = SecureRandom.hex
  end

end
