class NotificationController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index    
    @id = params[:id]

    pedidos = Pedido.where(company_id: @id).where(status: :pendente)
    render :json => pedidos.count   
    $pedidos_pendentes = []
    pedidos.each do |pedido|
      
      data = {
        'numero': "#{pedido.numero}" ,
         'id': pedido.id     
      }
      $pedidos_pendentes.push(data)
    end   
    puts $pedidos_pendentes
  end

end
