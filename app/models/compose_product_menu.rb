class ComposeProductMenu < ApplicationRecord
  belongs_to :product
  belongs_to :product_simple
end
