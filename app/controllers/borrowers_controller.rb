class BorrowersController < ApplicationController
  def index
  end

  def show
  	@borrower = Borrower.find(session[:user_id])
  	# @lenders = Lender.all.joins('LEFT JOIN histories ON lenders.id = histories.lender_id').select("lenders.first_name, lenders.last_name, lenders.email, histories.amount")
  	@lenders = Borrower.all.joins('LEFT JOIN histories ON borrowers.id = histories.borrower_id').joins('LEFT JOIN lenders ON lenders.id = histories.lender_id').select('lenders.first_name AS lender_first_name, lenders.last_name AS lender_last_name, lenders.email AS lender_email,histories.amount AS lent,borrowers.id AS b_id')
  end

  def create
  	borrower = Borrower.new(borrower_params)
    if borrower.save
      flash[:success] = "Successfully Registered"
      session[:user_id] = borrower.id 
      redirect_to "/borrowers/#{session[:user_id]}"
    else
      flash[:bor_errors] = borrower.errors.messages
      redirect_to :back
    end
  end

  def update
  end

  private
  	def borrower_params
  		params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money, :purpose, :description, :raised)
  		
  	end
end
