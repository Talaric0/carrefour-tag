class Tag < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_many :locations, through: :orders
  has_one_attached :photo

  validates :plate, :model, :maker, :year, :nickname, presence: true
end
