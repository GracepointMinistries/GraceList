class HomeController < ApplicationController
  before_action :authenticate_user!

  # GET /home
  def index
    @categories = Category.includes(:posts).active.all

    respond_to do |format|
      format.html { render :index }
    end
  end
end
