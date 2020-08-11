class Admin::PedidosController < AdminController
  skip_before_action :verify_authenticity_token
  def index
    @pedidos = Pedido.where(company_id: $empresa).order('created_at DESC')
  end

  def edit
    
  end

  def update 
    pedido = Pedido.find(params[:pedido])
    pedido.status = params[:id].to_i
    pedido.save
    respond_to do |format|
      format.html{redirect_to '/admin/pedidos'}
    end
  end
end
