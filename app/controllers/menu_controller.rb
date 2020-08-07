class MenuController < ApplicationController
    layout 'cardapio'

    before_action :set_empresa_cardapio

    def set_empresa_cardapio_subdominio

        dominio = request.original_url.split('//')[1].split('.')[0]
        empresa = Company.find_by(dominio: dominio)
        if empresa.present?
            $empresaMenu = empresa
        else
            redirect_to '/404.html'
        end
    end   
    def set_empresa_cardapio         
        unless $empresaMenu.present?      
            empresa_barra = params[:id]
            empresa = Company.find_by(dominio: empresa_barra)
            if empresa.present?
                $empresaMenu = empresa            
            else
                redirect_to '/404.html'
            end
        end
    end  
end
