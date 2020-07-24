class Payment < ApplicationRecord
    enum tipo: [:credito, :debito, :avista]
end
