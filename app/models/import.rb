class Import < ApplicationRecord
  belongs_to :jurisdiction
  has_many :transactions, dependent: :destroy
  has_many :reports, dependent: :destroy
end
