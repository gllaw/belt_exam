class BorrowersController < ApplicationController
 
  before_action :require_login, except: [:create]
  before_action :require_correct_borrower, only: [:show]

  def create							#adding ppl to borrower table.
    borrower = Borrower.new(borrower_params)
  	if borrower.save
  	  session[:user_id] = borrower.id
  	  redirect_to "/borrowers/#{Borrower.last.id}"
  	else
  	  flash[:errors] = borrower.errors.full_messages
      redirect_to :back
    end
  end

  def show 								#borrower landing page
    @borrower = Borrower.find(params[:id])
  end

  def getting_money
  	lendings = Array.new
    lendings = History.select(:amount).where("borrower_id = session[:user_id]").to_a
    lendings.reduce(0, :+)
  end

  private
  def borrower_params
  	params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :purpose, :description, :money)
  end

end
