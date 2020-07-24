class Category < ApplicationRecord
  belongs_to :company
  has_one_attached :avatar_category
end
