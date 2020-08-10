class Admin::DashboardController < AdminController
  def index
    @cardapio = Product.where(company_id: $empresa).where(status: true).count
    @cliente = Client.where(company_id: $empresa).count
    @pedidos = Pedido.where(company_id: $empresa).count
    @faturamento = Pedido.where(company_id: $empresa).sum(:valor_total)
    
  end
end
