class Company < ApplicationRecord  
  belongs_to :admin
  has_many :products

  enum status: [:pendente, :ativa, :inativa]
end
