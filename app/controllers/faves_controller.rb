require 'mechanize'

class FavesController < ApplicationController
  
  def index
    @user_faves=Fave.where('user_id=?',current_user.id).reorder('created_at DESC').paginate(page:params[:page],:per_page=>10)
    # binding.pry
    @fave=Fave.new
  end

  def create

    # scrape page title
    page=Fave.new
    page.url=params["fave"][:url]
    page.page_title=get_url_title(params["fave"][:url])
    page.description=params['fave'][:description]
    page.user_id=current_user.id

    if page.save
      redirect_to faves_path, :notice => "Successively added one more faves"
    else
      redirect_to faves_path, :alert => "Failed adding fave list"
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
    redirect_to faves_path
  end

  def update
    @fave=Fave.find(params[:id])
    if @fave.update_attributes(params[:fave])
      flash[:success]="Updated"
      redirect_to faves_path
    else
      flash[:error]="Error updating"
      redirect_to edit_fav_path(@fave)
    end
  end
end
