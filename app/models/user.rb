class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :districts
  has_many :trackers
  has_many :tracker_additions, through: :trackers, source: :district  
  
  def subscribed?
    stripe_subscription_id?
  end
end
