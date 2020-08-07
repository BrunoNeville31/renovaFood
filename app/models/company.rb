class Company < ApplicationRecord  
  belongs_to :admin
  has_many :products
  has_one_attached :avatar_company

  enum status: [:pendente, :ativa, :inativa]
end
