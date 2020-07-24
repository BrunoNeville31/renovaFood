class Admin::AdminProfileController < AdminController
  before_action :edit, only: [:update]
  def edit
    @admin = Admin.find(params[:id])   
  end

  def update
    nome = params[:nome]
    sobrenome = params[:sobrenome]
    fone = params[:fone]
    
    email = params[:email]
    senha = params[:password]
    confirmacao_senha = params[:password_confirmation]

    if email.present?
      @admin.email = email
    elsif senha.present? && confirmacao_senha.present?
      @admin.password = senha
      @admin.password_confirmation = confirmacao_senha
    end
    @admin.save
    @admin_profile = AdminProfile.find_by(admin_id: @admin.id)    
    @admin_profile.nome = nome
    @admin_profile.fone = fone
    @admin_profile.sobrenome = sobrenome
    if params[:avatar_admin].present?
      img = params[:avatar_admin]
      @admin_profile.avatar_admin = img
    end
    
    if @admin_profile.save
      respond_to do |format|
        format.html{redirect_to admin_root_path, notice: 'Perfil Alterado com sucesso'}
      end
    end
  end
end
