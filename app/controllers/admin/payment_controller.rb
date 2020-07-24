class Admin::PaymentController < AdminController
  before_action :edit, only: [:update]
  def index    
    if params[:status].present?
      where += "and status = #{params[:status]}"
      @pagamentos =  Payment.where(where)
    else
      @pagamentos =  Payment.where(company_id: $empresa)
    end    
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def update
    @payment.status = params[:payment][:status].nil? ? false : true
    @payment.tipo = params[:payment][:tipo].to_i
    @payment.update(set_params)
    respond_to do |format|
      format.html{redirect_to admin_payment_index_path, notice: 'Forma de Pagamento Alterada com sucesso'}
    end
  end

  def new
    @payment = Payment.new
  end
  def create
    @payment = Payment.new(set_params)
    @payment.company_id = $empresa
    @payment.tipo = params[:payment][:tipo].to_i
    @payment.status = params[:payment][:status].nil? ? false : true
    respond_to do |format|
      if @payment.save
          format.html{redirect_to admin_payment_index_path, notice: 'Forma de Pagamento cadastrada com Sucesso'}
      else
          format.html{render :new}
      end
    end
  end

  def set_params
    params.require(:payment).permit(:status, :nome, :parcela, :num_parcela, :company_id)
  end
end
