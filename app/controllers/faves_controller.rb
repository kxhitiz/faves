require 'mechanize'

class FavesController < ApplicationController
  
  def index
    @user_faves = current_user.faves.reorder('created_at DESC').paginate(page:params[:page],:per_page=>10)
    @fave = current_user.faves.new
  end

  def create
    # scrape page title
    fave = current_user.faves.new(params["fave"])
    fave.page_title=get_url_title(fave.url)

    if fave.save
      redirect_to user_faves_path(current_user), :notice => "Successively added one more faves"
    else
      redirect_to user_faves_path(current_user), :alert => "Failed adding fave list"
    end
  end

  def new
    @fave=Fave.new
  end

  def edit
    @fave=Fave.find(params[:id])
  end

  # TODO Send to background
  # https://github.com/mperham/sidekiq
  #
  def get_url_title(url)
    browser=Mechanize.new
    browser.get(url).title
    rescue
      "URL unavailable"
  end

  def destroy
    if @fave=Fave.find(params[:id])
      @fave.destroy
      flash[:success]="Deleted"
    else
      flash[:error]="No such fav"
    end
    redirect_to user_faves_path(current_user)
  end

  def update
    @fave=Fave.find(params[:id])
    if @fave.update_attributes(params[:fave])
      flash[:success]="Updated"
      redirect_to user_faves_path(current_user)
    else
      flash[:error]="Error updating"
      redirect_to edit_user_fave_path(current_user, @fave)
    end
  end
end
