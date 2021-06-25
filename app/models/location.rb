class Location < ApplicationRecord
  CATEGORIES = ['Posto', 'Estacionamento', 'Pedágio', 'Mercado']
  has_many :orders
  validates :category, :name, presence: true
  validates :category,  inclusion: { in: CATEGORIES }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
