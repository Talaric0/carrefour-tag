class Order < ApplicationRecord
  belongs_to :location
  validates :value, presence: true
end
