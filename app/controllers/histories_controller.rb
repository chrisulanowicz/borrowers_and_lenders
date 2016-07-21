class HistoriesController < ApplicationController
  def update
  	lender = Lender.find(session[:user_id])
  	borrower = Borrower.find(params[:borrower_id])
  	if params[:lend].to_i <= lender.money
  		lender.money -= params[:lend].to_i
  		if lender.save
  			borrower.raised += params[:lend].to_i
  			if borrower.save
  				history = History.find_by(borrower_id: params[:borrower_id], lender_id:session[:user_id])
  				if history != nil
  					history.amount += params[:lend].to_i
  					history.save
  					redirect_to :back
  				else
	  				history = History.new(amount: params[:lend].to_i, lender_id: session[:user_id], borrower_id: params[:borrower_id])
	  				if history.save
	  					redirect_to :back
	  				else
	  					flash[:errors] = history.errors.full_messages
	  				end
  				end
  			else
  				flash[:errors] = borrower.errors.full_messages
  				redirect_to :back
  			end
  		else
  			flash[:errors] = lender.errors.full_messages
  			redirect_to :back
  		end
  	else
  		flash[:errors] = "Insufficient Funds"
  		redirect_to :back
  	end
  end
end
