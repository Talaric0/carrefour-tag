class Order < ApplicationRecord
  belongs_to :location
  belongs_to :tag

  validates :value, presence: true
end
