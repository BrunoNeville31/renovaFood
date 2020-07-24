class Admin::CompanyController < AdminController
  before_action :edit, only: [:update]
  def index
  end

  def new
    @company = Company.new
  end
  def create      
    @company = Company.new(set_params)
    @company.licenca = current_admin.admin_profile.licenca
    @company.admin_id = current_admin.id
    respond_to do |format|
      if @company.save
        format.html{redirect_to admin_root_path,notice: "Empresa criada com Sucesso!"}
      else
        format.html{redirect_to new_admin_company_path, notice: "Erro ao Cadastrar Empresa"}
      end
    end
  end
  def atualiza_pedido
    respond_to do |format|
      format.js
    end
  end

  def taxa_entrega   

    taxa = params[:taxa_entrega]
    emp = Company.find($empresa)
    emp.taxa_entrega = taxa
    emp.save

    respond_to do |format|
      format.js
    end
  end

  def consulta_pedido
    debugger
    params[:ordem_pedido] # params que chega
    respond_to do |format|
        format.js
    end
  end

  def edit
    @company = Company.find(params[:id])
  end
  def update
   respond_to do |format|
    if @company.update(set_params_update)
      format.html{redirect_to admin_root_path, notice: 'Empresa Editada com sucesso!'}
    else
      format.html{redirect_to edit_admin_company_path($empresa), notice: 'Erro ao Editar empresa'}
    end
   end
  end
  
  def show
    $empresa = params[:id].to_i
    redirect_to admin_root_path
  end

  def set_params
    params.require(:admin).permit(:nome, :rua, :numero, :estado, :cidade, :cep, :bairro, :licenca, :admin_id,
                                    :cnpj, :fone,:status,:data_cobranca,:taxa,:valor,:valor_centavos,:monday_open, 
                                    :monday_close,:tuesday_open,:tuesday_close,:wednesday_open,:wednesday_close,
                                    :thursday_open,:thursday_close,:friday_open,:friday_close,:saturday_open,
                                    :saturday_close,:sunday_open,:sunday_close) 
    
    end
    def set_params_update
      params.require(:company).permit(:nome, :rua, :numero, :estado, :cidade, :cep, :bairro, :licenca, :admin_id,
                                      :cnpj, :fone,:status,:data_cobranca,:taxa,:valor,:valor_centavos,:monday_open, 
                                      :monday_close,:tuesday_open,:tuesday_close,:wednesday_open,:wednesday_close,
                                      :thursday_open,:thursday_close,:friday_open,:friday_close,:saturday_open,
                                      :saturday_close,:sunday_open,:sunday_close) 
      
      end
end
