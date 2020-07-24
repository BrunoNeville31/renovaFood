class Admin::ProductSimpleController < AdminController
  before_action :edit, only: [:update]

  def index    
    where = "company_id = #{$empresa} "
    if params[:status].present?
      where += "and status = #{params[:status]}"
    else
      where += ""
    end
    @produto_Individual = ProductSimple.where(where)
  end

  def new
    @product_simple = ProductSimple.new
  end
  
  def create
    @product_simple = ProductSimple.new(set_params)
    @product_simple.company_id = $empresa
    @product_simple.status = params[:product_simple][:status].nil? ? false : true
    respond_to do |format|
      if @product_simple.save
          format.html{redirect_to admin_product_simple_index_path, notice: 'Produto Individual cadastrado com sucesso'}
      else
          format.html{render :new}
      end
    end
  end

  def edit
    @product_simple = ProductSimple.find(params[:id])
  end

  def update
    @product_simple.status = params[:product_simple][:status].nil? ? false : true
    if @product_simple.update(set_params)
      respond_to do |format|
        format.html{redirect_to admin_product_simple_index_path, notice: 'Produto Individual Atualizado com sucesso'}
      end
    end
  end

  def set_params
    params.require(:product_simple).permit(:nome, :valor, :estoque_min, :estoque_atual, :status, :company_id)
  end
end
