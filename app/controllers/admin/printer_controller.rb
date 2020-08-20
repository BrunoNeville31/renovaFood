class Admin::PrinterController < ApplicationController
  before_action :set_company
  def index
  end

  def set_company
    @pedido = Pedido.find(params[:id])
    $empresaPedido = Company.find(@pedido.company_id)
  end
end
