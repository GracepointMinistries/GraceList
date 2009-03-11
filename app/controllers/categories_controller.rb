class CategoriesController < ApplicationController
  def index
    @category = Category.find_by_id(params[:id])
    if @category
      @post_pages, @posts = paginate :posts, :per_page => 20, :order => "created_at DESC", :conditions => ["category_id = ?", @category.id]
    else
      flash[:notice] = 'Please provide a valid category.'
      redirect_to :action => 'index'
    end
  end
end