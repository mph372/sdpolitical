class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :dashboardable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable#, :confirmable

  has_many :districts
  has_many :dashboards
  has_many :dashboard_additions, through: :dashboards, source: :district  
  acts_as_follower
  
  def subscribed?
    stripe_subscription_id?
  end
end
