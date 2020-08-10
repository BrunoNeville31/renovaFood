class NotificationController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index    
    @id = params[:id]

    pedidos = Pedido.where(company_id: @id).where(status: :pendente)
    render :json => pedidos.count   
    $pedidos_pendentes = []
    pedidos.each do |pedido|
      data = {
        'numero': "#{pedido.numero}"        
      }
      $pedidos_pendentes.push(data)
    end   
    puts $pedidos_pendentes
  end

  def atualiza_pedido
    debugger

    x = 1
  end
end
