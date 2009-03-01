class PostsController < ApplicationController
  caches_page :rss
  cache_sweeper :post_sweeper

  def index
    @categories = Category.find(:all, :conditions => ["name != 'Announcements'"])
    @announcements = Category.find_all_by_name('Announcements')
  end

  def list
    @category = Category.find_by_id(params[:category_id])
    if @category
      @post_pages, @posts = paginate :posts, :per_page => 20, :order => "created_at DESC", :conditions => ["category_id = ?", @category.id]
    else
      flash[:notice] = 'Please provide a valid category.'
      redirect_to :action => 'index'
    end
  end

  def show
    begin
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = 'Sorry, post not found.  It was probably deleted by somebody.'
      redirect_to :action => 'index'
    end
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
    flash[:notice] = 'Post has been deleted.'
    redirect_to :action => 'index'
  end
  
  # About GraceList
  def about
  end

  # RSS Feed
  def rss
    @posts = Post.find(:all, :limit => 25, :order => "created_at DESC").reverse
    render :layout => false
  end
  
  # Convenience action to preview the newsletter
  def newsletter
    index
    render :layout => false
  end
  
  # Send out newsletter
  def notify    
    # Render the newsletter
    index
    body = render_to_string :action => 'newsletter', :layout => 'mail'
    recent_items = Post.recent_items
    # Deliver the newsletter
    if (recent_items > 0)
      Notifier.deliver_newsletter(body, recent_items.to_s)
      flash[:notice] = 'Newsletter has been sent.'
    else
      flash[:notice] = 'There are no recent items these past ' + (7.0/NOTIFY_FREQUENCY).to_s + ' days, so no newsletter needs to be sent'
    end
    
    redirect_to :action => 'index'
  end
end
