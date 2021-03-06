class UsersController < ApplicationController

  before_filter :authenticate, only:[:edit, :update]
  before_filter :correct_user, only:[:edit, :update]

  def new
    @user=User.new
  end

  def create
    @user=User.new(params[:user])
    if @user.save
      flash[:success]="Successfully registered"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user=User.find(params[:id])
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success]='Account details updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def authenticate 
      redirect_to signin_url, 
        notice:'You must signin to continue' unless signed_in?
    end

    def correct_user
      @user=User.find(params[:id])
      unless current_user?(@user)
        flash[:error]="Sorry, can't do that :("
        redirect_to(user_path(current_user))
      end
    end
end
