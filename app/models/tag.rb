class Tag < ApplicationRecord
  belongs_to :user

  has_one_attached :photo

  validates :plate, :model, :maker, :nickname, presence: true
end
