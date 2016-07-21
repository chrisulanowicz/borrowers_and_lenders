class LendersController < ApplicationController
  def index
  end

  def new
  	
  end

  def show
  	@lender = Lender.find(session[:user_id])
  	@borrowers = Borrower.all.joins('LEFT JOIN histories ON borrowers.id = histories.borrower_id').joins('LEFT JOIN lenders ON lenders.id = histories.lender_id').select('borrowers.id AS Bid, borrowers.first_name AS BFName, borrowers.last_name AS BLName, borrowers.purpose, borrowers.description, borrowers.money AS needed, borrowers.raised,histories.amount AS lent, histories.lender_id AS Lid')
  end

  def create
  	lender = Lender.new(lender_params)
    if lender.save
      flash[:success] = "Successfully Registered"
      session[:user_id] = lender.id 
      redirect_to "/lenders/#{session[:user_id]}"
    else
      flash[:errors] = lender.errors.messages
      redirect_to :back
    end
  end

  def update
  end

  private

  	def lender_params
  		params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money) 		
  	end
end
