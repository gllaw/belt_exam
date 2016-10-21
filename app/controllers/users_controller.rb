class UsersController < ApplicationController 
						#I meant to call this Sessions aaaaah nooooo

  def index								#login view
  end

  def new								#reg view
  end

  def create 				#login/new session, since it's one form...
  	if Lender.exists?(email: user_params[:email])
  	  user = Lender.find_by_email(user_params[:email])
      if (user && user.authenticate(user_params[:password]))
        session[:user_id] = user.id
        redirect_to "/lenders/#{session[:user_id]}"
      else
        flash[:error] = "Invalid Login"
        redirect_to :back
      end
    else #Borrower.exists?(email: user_params[:email])
      user = Borrower.find_by_email(user_params[:email])
      if (user && user.authenticate(user_params[:password]))
        session[:user_id] = user.id
        redirect_to "/borrowers/#{session[:user_id]}"
      else
        flash[:error] = "Invalid Login"
        redirect_to :back
      end
    end
  end

  def destroy 							#logging out
  	reset_session
	redirect_to :root
  end
  
  private
  def user_params
  	params.require(:user).permit(:email, :password)
  end
end
