class ProductSimple < ApplicationRecord
    has_many :side_products_setps
    #monetize :valor_cents
end
