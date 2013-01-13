class FavesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @faves = current_user.faves
  end

  def create
    fave = current_user.faves.new(params[:fave])
    if fave.save
	    redirect_to faves_index_path, :notice => "Successively added one more faves"
    else
	    redirect_to faves_index_path, :alert => "Failed adding fave list"
    end
  end
end
