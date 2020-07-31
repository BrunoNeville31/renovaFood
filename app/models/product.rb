class Product < ApplicationRecord
  belongs_to :company
  belongs_to :category
  has_one_attached :avatar_product

 # monetize :valor_cents
 # monetize :valor_promocional_cents

  def self.new_product
   #puts "#{self}"
  end
end
