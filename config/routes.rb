Rails.application.routes.draw do  
  
post '/bot/auth', to: 'bot/start#auth'
get '/bot/init', to: 'bot/start#init'
post '/bot/conversation', to: 'bot/start#conversation'

  namespace :menu do
    root 'cardapio#index'
    get '/product/:id', to: 'cardapio#produto_unico'
    get '/group/:id', to: 'cardapio#grupo'
    post '/armazena_pedido', to: 'cardapio#armazena_pedido'
    get '/finaliza_pedido', to: 'cardapio#finalizar_pedido'    
  end

  namespace :admin do
    root 'dashboard#index'
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
