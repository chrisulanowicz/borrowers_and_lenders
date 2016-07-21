class SessionsController < ApplicationController
	def index
		
	end

	def new
		
	end

	def create
		lender = Lender.find_by(email: params[:email])
		borrower = Borrower.find_by(email: params[:email])
		if lender && lender.authenticate(params[:password])
			session[:user_id] = lender.id 
			redirect_to "/lenders/#{session[:user_id]}"
		elsif borrower && borrower.authenticate(params[:password])
			session[:user_id] = borrower.id
			redirect_to "/borrowers/#{session[:user_id]}"
		else
			flash[:errors] = "Email or Password is incorrect"
			redirect_to :back
		end
  	end

    def destroy
    	session.clear
    	redirect_to :root
    end

end
