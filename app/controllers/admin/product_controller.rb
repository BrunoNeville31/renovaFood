class Admin::ProductController < AdminController
  before_action :edit, only: [:update]
  def index
    
    @categorias = Category.where(company_id: $empresa)
    where = "company_id = #{$empresa} "
    if params[:status].present?
      where += "and status = #{params[:status]}"
    else
      where += ""
    end

    if params[:categoria].present?
      where += "and category_id = #{params[:categoria]}"
    else
      where += ""
    end
    
      @produtos = Product.where(where).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @categorias = Category.where(company_id: $empresa)
    @product_simples = ProductSimple.where(company_id: $empresa).where(status: true)
  end

  def create  
    #Produto e Promocao Ativa
    produtoAtivo = params[:product][:ativoProduto].nil? ? false : true
    promocaoAtiva = params[:product][:promocaoAtiva].nil? ? false : true

    #Dias da Semana 
    monday    =   params[:product][:monday].nil? ? false : true
    tuesday   =   params[:product][:tuesday].nil? ? false : true
    wednesday =   params[:product][:wednesday].nil? ? false : true
    thursday  =   params[:product][:thursday].nil? ? false : true
    friday    =   params[:product][:friday].nil? ? false : true
    saturday  =   params[:product][:saturday].nil? ? false : true
    sunday    =   params[:product][:sunday].nil? ? false : true

    

    produto = Product.new
    produto.nome = params[:product][:nome]
    produto.descricao = params[:product][:descricao]
    produto.valor = params[:product][:valor].gsub(',','.').to_f
    produto.valor_promocional = params[:product][:vl_promocional].gsub(',','.').to_f
    produto.promocao_ativa = promocaoAtiva
    produto.category_id = params[:product][:categoria]       
    produto.avatar_product = params[:avatar_product]
    produto.tempo_preparo = params[:product][:tempo_preparo]
    produto.company_id = $empresa
    produto.status = produtoAtivo
    produto.monday = monday
    produto.tuesday =  tuesday
    produto.wednesday = wednesday
    produto.thursday = thursday
    produto.friday = friday
    produto.saturday = saturday
    produto.sunday = sunday
    debugger
    x = 1
    respond_to do |format|
      if produto.save!        
        if params[:product_simple].present?
          params[:product_simple].each do |key, value|
            composicao = ComposeProductMenu.new
            composicao.product_id = produto.id
            composicao.product_simple_id = value[:id]
            composicao.qtd = value[:qtd]
            composicao.save!                                
          end
        end   
        if params[:product_adicionais].present?
          params[:product_adicionais].each do |key, value|
              adicional = ProductStep.new
              adicional.descricao = value[:acompanhamento]
              adicional.product_id = produto.id
              adicional.company_id = $empresa
              adicional.limite = value[:qtd]
              
              if adicional.save
                if value[:product_add].present?
                  value[:product_add].each do |chave, valor|
                    adicionalProduto = SideProductStep.new
                    adicionalProduto.valor = valor[:valor_add]
                    adicionalProduto.product_simples_id = valor['id'] 
                    adicionalProduto.product_step_id = adicional.id
                    adicionalProduto.save!                        
                  end
                end
              end
          end
        end
        format.html{redirect_to admin_product_index_path, notice: 'Produto cadastrado com Sucesso!'}
      else
        format.html{render new , notice: 'Erro ao cadastrar Produto'}
      end
    end    
  end

  def edit
    @product = Product.find(params[:id])
    @composicaos = ComposeProductMenu.find_by(product_id: params[:id])
    @produto_acompanhamentos = ProductStep.find_by(product_id: params[:id]) 
    @categorias = Category.where(company_id: $empresa)   
    @product_simples = ProductSimple.where(company_id: $empresa).where(status: true)
  end
  def update

    #Produto e Promocao Ativa
    produtoAtivo = params[:product][:ativoProduto].nil? ? false : true
    promocaoAtiva = params[:product][:promocaoAtiva].nil? ? false : true

    #Dias da Semana 
    monday    =   params[:product][:monday].nil? ? false : true
    tuesday   =   params[:product][:tuesday].nil? ? false : true
    wednesday =   params[:product][:wednesday].nil? ? false : true
    thursday  =   params[:product][:thursday].nil? ? false : true
    friday    =   params[:product][:friday].nil? ? false : true
    saturday  =   params[:product][:saturday].nil? ? false : true
    sunday    =   params[:product][:sunday].nil? ? false : true   

    
    @product.nome = params[:product][:nome]
    @product.descricao = params[:product][:descricao]
    @product.valor = params[:product][:valor].gsub(',','.').to_f
    @product.valor_promocional = params[:product][:vl_promocional].gsub(',','.').to_f
    @product.promocao_ativa = promocaoAtiva
    @product.category_id = params[:product][:categoria]       
    @product.avatar_product = params[:avatar_product]
    @product.tempo_preparo = params[:product][:tempo_preparo]
    @product.company_id = $empresa
    @product.status = produtoAtivo
    @product.monday = monday
    @product.tuesday =  tuesday
    @product.wednesday = wednesday
    @product.thursday = thursday
    @product.friday = friday
    @product.saturday = saturday
    @product.sunday = sunday

    respond_to do |format|
      if @product.save!
        format.html{redirect_to admin_product_index_path, notice: 'Produto atualizado com Sucesso!'}
      else
        format.html{render new , notice: 'Erro ao atualizar Produto'}
      end
    end
  end

  def set_params
    params.require(:product).permit(:avatar_product)
  end
end
