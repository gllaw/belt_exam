class LendersController < ApplicationController

  before_action :require_login, except: [:create]
  before_action :require_correct_lender, only: [:show, :update, :destroy]

  def create 							#adding ppl to lender table.
  	lender = Lender.new(lender_params)
  	if lender.save
  	  session[:user_id] = lender.id
  	  redirect_to "/lenders/#{Lender.last.id}"
  	else
  	  flash[:errors] = lender.errors.full_messages
      redirect_to :back
    end
  end

  def show 								#lender landing page
    @lender = Lender.find(params[:id])
  end

  def update #lend money
  	
  end

  def destroy #cancel lending money?
  end

  private
  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
  end

end
