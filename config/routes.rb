Rails.application.routes.draw do  
  
 
get 'notification/index'
post '/bot/auth', to: 'bot/start#auth'
get '/bot/init', to: 'bot/start#init'
post '/bot/conversation', to: 'bot/start#conversation'
root 'admin/dashboard#index'

get '/cardapio/:id', to: 'menu/cardapio#index'
get '/notifica_pedido/:id', to: 'notification#index'
  namespace :menu do
    root 'cardapio#index'
    
    get '/product/:id', to: 'cardapio#produto_unico'
    get '/group/:id', to: 'cardapio#grupo'
    post '/armazena_pedido', to: 'cardapio#armazena_pedido'
    get '/detalhes_pedido', to: 'cardapio#detalhes_pedido' 
    get '/limpar_carrinho', to: 'cardapio#limpar_carrinho' 
    post '/altera_forma_pagamento', to: 'cardapio#altera_forma_pagamento'
    post '/altera_endereco_entrega', to: 'cardapio#altera_endereco_entrega'
    get '/finaliza_pedido', to: 'cardapio#finaliza_pedido'
    post '/finaliza_pedido/salvar', to: 'cardapio#salvar_perfil'
    get '/pedido_finalizado', to: 'cardapio#concluido'
    get '/perfil', to: 'cardapio#perfil'
  end

  namespace :admin do
    root 'dashboard#index'
    get '/impressao/:id', to: 'printer#index'
    resources :delivery
    resources :client
    resources :product
    resources :category
    resources :company
    resources :product_simple
    resources :payment
    resources :admin_profile, only: [:edit, :update]
    get '/taxa_entrega', to: 'company#taxa_entrega'
    get '/consulta_pedido', to: 'company#consulta_pedido'
    get '/atualizaStatus', to: 'company#atualiza_pedido'
    resources :pedidos, only:[:edit, :update, :index]
    get '/imprimir/teste', to: 'company#impressao'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    unlocks: 'users/unlocks'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    confirmations: 'admins/confirmations',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
    unlocks: 'admins/unlocks'
  }
end
