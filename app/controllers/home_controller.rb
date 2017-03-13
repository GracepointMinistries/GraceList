class HomeController < ApplicationController
  # GET /home
  def index
    @categories = Category.includes(:posts).active.all

    respond_to do |format|
      format.html { render :index }
    end
  end
end
