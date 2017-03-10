class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    if @category
      @posts = Post.in_category(@category).most_recent.paginate(page: params[:page], per_page: 20)
    else
      redirect_to categories_path, alert: 'Please provide a valid category.'
    end
  end
end