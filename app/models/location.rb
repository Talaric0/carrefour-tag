class Location < ApplicationRecord
  CATEGORIES = ['Posto', 'Estacionamento', 'Pedágio', 'Mercado']
  has_many :orders
  validates :category, :name, presence: true
  validates :category,  inclusion: { in: CATEGORIES }
end
