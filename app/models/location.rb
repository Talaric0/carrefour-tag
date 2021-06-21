class Location < ApplicationRecord
  CATEGORIES = ['posto de gasolina', 'estacionamento', 'pedágio']
  has_many :orders
  validates :category, :name, presence: true
  validates :category,  inclusion: { in: CATEGORIES }
end
