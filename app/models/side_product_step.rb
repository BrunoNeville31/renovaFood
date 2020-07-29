class SideProductStep < ApplicationRecord
  belongs_to :product_step
  belongs_to :product_simple
end
