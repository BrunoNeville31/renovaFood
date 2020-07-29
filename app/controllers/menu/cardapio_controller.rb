class Menu::CardapioController < MenuController
    def index
        $empresaMenu = Company.find(params[:id])
        $categorias = Category.where(company_id: params[:id])
        @categorias = Category.where(company_id: params[:id])
        @produtos_promocao = Product.where(company_id: params[:id]).where(status: true).where(promocao_ativa: true)
        @produtos_novos = Product.where(company_id: params[:id]).where(status: true)
        $cliente = Client.find(params[:client])
    end

    def produto_unico    
        @produto = Product.find(params[:id])
        @acompanhamentoBase = ProductStep.where(product_id: params[:id])  
    end
      
    def grupo    
        @produtos = Product.where(category_id: params[:id])
        @categoria = Category.find(params[:id])
    end
    
    def armazena_pedido
        
        respond_to do |format|
            format.html{redirect_to "/menu/finaliza_pedido/", notice: 'Pedido Adicionado com sucesso!'}
        end
    end
    def finalizar_pedido
        @pagamentos = Payment.where(status: true).where(company_id: $empresaMenu.id)
    end
    
end
