class Pedido < ApplicationRecord
  belongs_to :client
  enum status: [:pendente, :aceito, :recusado, :preparacao, :entrega, :concluido]
end
