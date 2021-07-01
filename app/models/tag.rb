class Tag < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :locations, through: :orders
  has_one_attached :photo
end
