class Menu::CardapioController < MenuController
    def index        
        $categorias = Category.where(company_id: $empresaMenu.id)
        
        @produtos_promocao = Product.where(company_id: $empresaMenu.id).where(status: true).where(promocao_ativa: true)
        @produtos_novos = Product.where(company_id: $empresaMenu.id).where(status: true).order('id DESC').limit(3)        
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
        require 'securerandom'
        adicionais = [] 

        if params[:adicional].present?
            params[:adicional].each do |chave, valor|
                valor.each do |idProductStep, qtdAdicional|
                    produtoAdicional = SideProductStep.find(idProductStep)
                    produtoAdicionalNome = ProductSimple.find(produtoAdicional.product_simples_id)
                    unless qtdAdicional.to_i == 0
                        adicional = [
                            "adicional": "#{produtoAdicionalNome.nome.upcase}",
                            "qtd": "#{qtdAdicional}",
                            "adicional_id": "#{produtoAdicionalNome.id}",
                            "product_step_id": "#{produtoAdicional.id}",
                            "valor_adicional": produtoAdicional.valor
                        ]  
                        adicionais.push(adicional[0]) 
                    end                
                end
            end
        end

        if $pedido.present?
            segundo_pedido(adicionais, params)
            saldoInicio = params[:valor_final].to_f +  session[:valor_final].to_f       
            session[:valor_final] = saldoInicio
        else
            primeiro_pedido(adicionais, params)
            session[:valor_final] = params[:valor_final].to_f
        end

        
        respond_to do |format|
            format.html{redirect_to "/menu/detalhes_pedido/", notice: 'Pedido Adicionado com sucesso!'}
        end
    end
    def detalhes_pedido
        @pagamentos = Payment.where(status: true).where(company_id: $empresaMenu.id)
    end

    def primeiro_pedido(*adicionais, params)        
        produto = Product.find(params[:produto_cardapio])
        $pedido = [
            "codigo_pedido": SecureRandom.hex(4),
            "produto_cardapio_id": produto.id,
            "valor_com_adicional": params[:valor_final].to_f,
            "produto_cardapio": "#{produto.nome}",
            "adicionais":
                adicionais
        ]       
    end

    def segundo_pedido(*adicionais, params)
        produto = Product.find(params[:produto_cardapio])
        $pedido += [
            "produto_cardapio_id": produto.id,
            "valor_com_adicional": params[:valor_final].to_f,
            "produto_cardapio": "#{produto.nome}",
            "adicionais":
                adicionais
        ] 
    end

    def limpar_carrinho
        $pedido = nil  
        $formaPagamento = nil      
        respond_to do |format|
            format.html{redirect_to '/menu', notice: 'Carrinho Vazio'}
        end
    end

    def altera_forma_pagamento
        
        $formaPagamento = []
        if params[:pag].present?
            params[:pag].each do |chave, valor|
                pagamento = Payment.find(chave)                
                $formaPagamento.push(pagamento.nome)
            end
            respond_to do |format|
                format.js
            end
        else
            respond_to do |format|
                format.js
            end
        end
    end
   
end
