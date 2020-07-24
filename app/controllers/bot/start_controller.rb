class Bot::StartController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    def init
       
        require 'net/http'
        uri = URI("http://localhost:3001/whatApp/#{$empresa}")
        res = Net::HTTP.post_form(uri, 'empresa' => "#{$empresa}")       
        respond_to do |format|
            format.js
        end
    end
    def auth        
        venda = Company.find($empresa)
        venda.venda_bot = params[:venda_bot]
        venda.save

        respond_to do |format|
            format.js
        end
    end

    def conversation  
      
        if params[:empresa][:body].downcase == "oi" 
            empresaNumero = params[:empresa][:to].gsub('@c.us', '').gsub('55','')
            aberto = Time.now.strftime('%A').downcase + "_open"
            fechado = Time.now.strftime('%A').downcase + "_close"
            empresa = Company.select("#{aberto} as aberto", "#{fechado} as fechado", 'nome', 'venda_bot', 'id').find_by(fone: empresaNumero)     
                                
            if empresa.present? && empresa.venda_bot == true
               
                if empresa.aberto.to_time <= Time.now && empresa.fechado.to_time >= Time.now
                
                    if params[:empresa][:sender][:isBusiness] == true

                        nome = params[:empresa][:sender][:name]
                        clientFone = params[:empresa][:from].gsub('@c.us','').gsub('55','')
                        client = Client.find_by(fone: clientFone)
                        if client.present?
                            client.src = params[:empresa][:sender][:profilePicThumbObj][:eurl]
                            client.save
                        else                           
                            client = Client.new
                            client.nome = nome
                            client.fone = clientFone
                            client.src = params[:empresa][:sender][:profilePicThumbObj][:eurl]
                            client.company_id = empresa.id
                            client.save
                        end
                    else
                       
                        nome = params[:empresa][:sender][:pushname]
                        clientFone = params[:empresa][:from].gsub('@c.us','').gsub('55','')
                        client = Client.find_by(fone: clientFone)
                        if client.present?
                            client.src = params[:empresa][:sender][:profilePicThumbObj][:eurl]
                            client.save
                        else                           
                            client = Client.new
                            client.nome = nome
                            client.fone = clientFone
                            client.src = params[:empresa][:sender][:profilePicThumbObj][:eurl]
                            client.company_id = empresa.id
                            client.save
                        end                        
                    end 
                    @response = "Olá #{nome}, Seja Bem Vindo a empresa #{empresa.nome} !. Caso queira acessar o cardápio basta enviar 1"
                    render :json => @response
                else
                    @response = "Olá #{nome}, Neste momento não estamos atendendo no momento, nosso horário de Abertura é  das #{empresa.aberto} às #{ empresa.fechado } !"
                    render :json => @response
                end
                
            end
        elsif params[:empresa][:body].downcase.parameterize == "cardapio" || params[:empresa][:body] == "1"

            clientFone = params[:empresa][:from].gsub('@c.us','').gsub('55','')
            @client = Client.find_by(fone: clientFone)
       
            empresaNumero = params[:empresa][:to].gsub('@c.us', '').gsub('55','')
            aberto = Time.now.strftime('%A').downcase + "_open"
            fechado = Time.now.strftime('%A').downcase + "_close"
            @empresa = empresa = Company.select("#{aberto} as aberto", "#{fechado} as fechado", 'nome', 'venda_bot', 'id').find_by(fone: empresaNumero)

            @response = "Certo, vou te mandar o cardápio agora mesmo..http://localhost:3000/menu/?id=#{@empresa.id}&client=#{@client.id}"
            render :json => @response
                       
        end       
    end

   
end
