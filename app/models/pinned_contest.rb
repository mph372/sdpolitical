class PinnedContest < ApplicationRecord
  belongs_to :user
  belongs_to :contest
  
  validates :user_id, uniqueness: { scope: :contest_id }
  validates :pin_order, presence: true
  
  # Automatically assign the next pin_order when created
  before_validation :set_pin_order, on: :create
  
  private
  
  def set_pin_order
    return if pin_order.present?
    last_order = user.pinned_contests.maximum(:pin_order) || 0
    self.pin_order = last_order + 1
  end
end