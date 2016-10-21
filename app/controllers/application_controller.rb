class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_user
    if session[:user_id]
    	if Lender.exists?(session[:user_id])
    	  Lender.find(session[:user_id])
    	else #Borrower.exists?(session[:user_id])
          Borrower.find(session[:user_id])
          # reset_session
          # redirect_to :root
        end
    end
  end
  helper_method :current_user


  def require_login
    redirect_to :root if session[:user_id] == nil
  end


  def require_correct_lender
    user = Lender.find(params[:id])
    redirect_to "/lenders/#{session[:user_id]}" if current_user != user
  end


  def require_correct_borrower
    user = Borrower.find(params[:id])
    redirect_to "/borrowers/#{session[:user_id]}" if current_user != user
  end

end
