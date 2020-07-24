class Admin::ClientController < AdminController
  before_action :edit, only: [:update]
  def index

    @clients = Client.where(company_id: $empresa)
  end

  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(set_params)
    @client.status = params[:client][:status].nil? ? false : true
    @client.company_id = $empresa
    respond_to do |format|
      if @client.save
        format.html{redirect_to admin_client_index_path, notice: 'Cliente Salvo com sucesso'}
      else
        format.html{render :new}
      end
    end
  end

  def update    
    @client.status = params[:client][:status].nil? ? false : true
   
    if @client.update(set_params)
      respond_to do |format|
        format.html{ redirect_to admin_client_index_path, notice: 'Cliente Editado com sucesso'}
      end
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def set_params
    params.require(:client).permit(:nome,:fone,:cpf,:email,:rua,:numero,:cidade,:estado,:cep,:complemento,:status,:aniversario)
  end
end
