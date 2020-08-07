class Menu::CardapioController < MenuController
    def index        
        $categorias = Category.where(company_id: $empresaMenu.id)
        
        @produtos_promocao = Product.where(company_id: $empresaMenu.id).where(status: true).where(promocao_ativa: true)
        @produtos_novos = Product.where(company_id: $empresaMenu.id).where(status: true).order('id DESC').limit(3)   
        unless $perfil.present?
            $perfil = {} 
        end    
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
        @delivery = DeliveryPrice.where(company_id: $empresa)
        unless $entrega.present?
            $entrega = {}
        end
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


    def altera_endereco_entrega
        
        bairro = DeliveryPrice.find(params[:delivery_address])
        $entrega[:bairro] = bairro.bairro_nome
        $entrega[:rua] = params[:rua]
        $entrega[:numero] = params[:numero]
        $entrega[:complemento] = params[:complemento]
        $entrega[:cidade] = params[:cidade]
        $entrega[:valor] = bairro.valor.to_f
        
        respond_to do |format|
            format.js
        end
    end

    def finaliza_pedido  
         debugger
         x = 1
        if $perfil[:numero].nil?                        
            respond_to do |format|
                format.html{redirect_to '/menu/perfil', notice: 'Preencha seus dados para finalizar o Pedido'}
            end         
        else
            if $entrega[:bairro].nil?
                respond_to do |format|
                    format.html{redirect_to '/menu/detalhes_pedido' }
                end
            else
                salvar_pedido
                respond_to do |format|
                    format.html{redirect_to '/menu/pedido_finalizado' }
                end                
            end            
        end        
    end

    def concluido;end

    def perfil;end

    def salvar_perfil        
        if params[:email].present?
            $perfil[:email] = params[:email]
        end
        if params[:numero].present?
            $perfil[:numero] = params[:numero]
        end
        respond_to do |format|            
            format.html{redirect_to '/menu'}            
        end
    end

    def salvar_pedido       
        cliente = Client.find_by(numero: $perfil[:numero])
        unless cliente.present?
            cliente = Client.new
            cliente.numero = $perfil[:numero]
            cliente.email = $perfil[:email]
            cliente.save
        end
       
        pedido = Pedido.new
        pedido.numero = $pedido[0][:codigo_pedido]
        pedido.entrega_rua = $entrega[:rua]
        pedido.entrega_cidade = $entrega[:cidade]
        pedido.entrega_complemento = $entrega[:complemento]
        pedido.entrega_bairro = $entrega[:bairro]
        pedido.taxa_entrega = $entrega[:valor]
        pedido.client_id = cliente.id
        pedido.valor_total = session[:valor_final] + $entrega[:valor]
        pedido.status = :pendente
        pedido.company_id = $empresaMenu.id
        if pedido.save           
            $pedido.each do |item_pedido|               
                adicional_pedido = ItensPedido.new
                adicional_pedido.pedido_id = pedido.id
                adicional_pedido.adicional_nome = item_pedido[:produto_cardapio]
                adicional_pedido.adicional_id = item_pedido[:produto_cardapio_id]   #Esses campos busca o produto e não o adicional
                adicional_pedido.valor = item_pedido[:valor_com_adicional]
                if adicional_pedido.save
                    if item_pedido[:adicionais][0].present?
                        item_pedido[:adicionais][0].each do |adicional_item|                           
                            adicional_pedido_adicionais = ItensAdicionalPedido.new
                            adicional_pedido_adicionais.nome =  adicional_item[:adicional]
                            adicional_pedido_adicionais.insumo_id = adicional_item[:product_step_id]
                            adicional_pedido_adicionais.itens_pedido_id =  adicional_pedido.id
                            adicional_pedido_adicionais.product_step_id = adicional_item[:product_step_id]
                            adicional_pedido_adicionais.qtd =   adicional_item[:qtd]
                            adicional_pedido_adicionais.valor_adicional =   adicional_item[:valor_adicional]
                            adicional_pedido_adicionais.save
                        end
                    end
                end
            end            
        end
    end
   
end
