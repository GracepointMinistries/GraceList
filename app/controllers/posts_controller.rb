class PostsController < ApplicationController
  def index
    @categories = Category.find_all
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @category = Category.find_by_id(params[:category_id])
    if @category
      @post_pages, @posts = paginate :posts, :per_page => 10, :conditions => ["category_id = ?", @category.id]
    else
      flash[:notice] = 'Please provide a valid category.'
      redirect_to :action => 'index'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    
    # Initialize category_id if passed in
    @post.category_id = params[:category_id] if params[:category_id]
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = 'Your post has been added.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = 'Post was successfully updated.'
      redirect_to :action => 'show', :id => @post
    else
      render :action => 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  # About GraceList
  def about
  end
  
  # Convenience action to preview the newsletter
  def newsletter
    index
    render :layout => false
  end
  
  # Send out newsletter
  def notify    
    # Render the newsletter
    @categories = Category.find_all
    body = render_to_string :action => 'newsletter', :layout => 'mail'
    
    # Deliver the newsletter
    Notifier.deliver_newsletter(body, Post.recent_items.to_s)
    flash[:notice] = 'Newsletter has been sent.'
    redirect_to :action => 'index'
  end
end
