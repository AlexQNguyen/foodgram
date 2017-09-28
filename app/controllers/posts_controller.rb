class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    @posts= Post.create(post_params)
    if @posts.valid?
      redirect_to "/users/#{current_user.id}/posts"
    else
      flash[:errors] = @posts.errors.full_messages
      redirect_to "/users/#{current_user.id}/posts/new"
    end

  end

  def new
    @post = Post.new
  end

  def show
    @posts = Post.where("user_id=?", "#{current_user.id}" )
  end

  def edit
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])

  end

  def update
    @post = Post.find(params[:post_id])
      if @post.update(update_params)
        redirect_to "/users/#{current_user.id}/posts"
      else
        flash[:errors] = @post.errors.full_messages
        redirect_to '/users/:user_id/posts/:post_id/edit'
      end
  end

  def delete
    Post.find(params[:post_id]).destroy
    redirect_to "/users/#{current_user.id}/posts"
  end

  private
  def post_params
    params.require(:post).permit(:image, :description, :user_id, :review, :name)
  end
  def update_params
    params.require(:post).permit(:image, :description, :user_id, :post_id, :review, :name)
  end
  def check_session
    if !session[:user_id]
      redirect_to '/'
    end
  end

end
