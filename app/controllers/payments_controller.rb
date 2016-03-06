class PaymentsController < ApplicationController

	def index
	end

	def new
	    @payment = Payment.new
	end

	# POST /registrations
	def create
	    @payment = Payment.new(payment_params)
	    if @payment.save
	      redirect_to @payment.paypal_url(payments_path(@registration))
	    else
	      render :new
	    end
	end

	private 
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:email)
    end

	
end
