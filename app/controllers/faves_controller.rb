require 'open-uri'
require 'nokogiri'
class FavesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @faves = current_user.faves.all
  end

  def create

    # scrape page title
    page=Fave.new
    page.url=params["fave"][:url]
    page.page_title=get_url_title(params["fave"][:url])
    page.description=params['fave'][:description]
    page.user_id=current_user.id

    if page.save
	    redirect_to faves_index_path, :notice => "Successively added one more faves"
    else
	    redirect_to faves_index_path, :alert => "Failed adding fave list"
    end
  end

  def get_url_title(url)
    page=Nokogiri::HTML(open(url))
    page.title
  end

end
