class Admin::CategoryController < AdminController
  before_action :edit, only: [:update]

  def index
    @categorias = Category.where(company_id: $empresa)
  end

  def new
    @categoria = Category.new
  end
  
  def create
    @categoria = Category.new(set_params)
    @categoria.company_id = $empresa
    respond_to do |format|
      if @categoria.save
        format.html{redirect_to admin_category_index_path, notice: 'Grupo Criado com Sucesso.'}
      else
        format.html{render :new , notice: 'Erro ao Cadastrar Grupo'}
      end
    end
  end

  def update
    if @categoria.update(set_params)
      respond_to do |format|
        format.html{redirect_to admin_category_index_path, notice: 'Categoria Editada com Sucesso'}
      end
    end
  end

  def edit
    @categoria = Category.find(params[:id])
  end

  def set_params
    params.require(:category).permit(:nome, :img, :company_id, :avatar_category)
  end
end
