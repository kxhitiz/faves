class SessionsController < ApplicationController
  def create
    user=User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash.now[:success]='You are signed in'
      redirect_to user
    else
      flash.now[:error]='Username/password incorrect'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end

  def new

  end
end
