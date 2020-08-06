class Admin::DeliveryController < AdminController
  before_action :edit, only: [:update]
  def index
    @entregas = DeliveryPrice.where(company_id: $empresa)
  end

  def new
    @delivery = DeliveryPrice.new
  end

  def create    
    @delivery = DeliveryPrice.new(set_params)
    if @delivery.valor.present? 
      valor = params[:delivery_price][:valor].gsub(',','.').to_f    
    end

    @delivery.valor = valor
    @delivery.company_id = $empresa
    respond_to do |format|
      if @delivery.save
        format.html{redirect_to admin_delivery_index_path, notice: 'Taxa adicionada com Sucesso'}
      else
        format.html{render :new, notice: 'Erro ao adicionar Taxa'}
      end
    end
  end

  def edit
    @delivery = DeliveryPrice.find(params[:id])
  end

  def update
    if params[:delivery_price][:valor].present? 
      valor = params[:delivery_price][:valor].gsub(',','.').to_f    
    end
    @delivery.valor = valor    
    respond_to do |format|
      if @delivery.save
        format.html{redirect_to admin_delivery_index_path, notice: 'Taxa editada com Sucesso'}
      else
        format.html{render :new, notice: 'Erro ao editar Taxa'}
      end
    end
  end

  def set_params
    params.require(:delivery_price).permit(:bairro_nome, :valor)
  end
end
