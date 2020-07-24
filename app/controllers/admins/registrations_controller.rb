# frozen_string_literal: true

class Admins::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
   def new    
     super
   end

  # POST /resource
   def create
     super

     licenca = Licenca.new
     licenca.numero = SecureRandom.hex(13)      
     licenca.status = :ativo
     licenca.save

     
     company = Company.new
     company.nome = params[:admin][:empresa_nome]
     company.rua = params[:admin][:rua]
     company.numero = params[:admin][:numero]     
     company.cidade = params[:admin][:cidade]
     company.cep = params[:admin][:cep]
     company.bairro = params[:admin][:bairro]
     company.licenca = licenca.numero
     company.admin_id = @admin.id
     company.cnpj = params[:admin][:cnpj]
     company.fone = params[:admin][:telefone]
     company.status = :pendente
     company.save
     
     admin_profile = AdminProfile.new
     admin_profile.admin_id = @admin.id
     admin_profile.licenca = licenca.numero
     admin_profile.nome = params[:admin][:nome]
     admin_profile.sobrenome = params[:admin][:sobrenome]     
     admin_profile.save     

   end

  # GET /resource/edit
   def edit
     super
   end

  # PUT /resource
   def update
     super
   end

  # DELETE /resource
   def destroy
     super
   end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
   def cancel
     super
   end

  protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
   end

  # The path used after sign up.
   def after_sign_up_path_for(resource)
     super(resource)
   end

  # The path used after sign up for inactive accounts.
   def after_inactive_sign_up_path_for(resource)
     super(resource)
   end
end
