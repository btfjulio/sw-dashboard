class Price < ApplicationRecord
  belongs_to :suplemento
  monetize :price_cents
end
