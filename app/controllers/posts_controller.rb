class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    params[:user_id] = Post.where("user_id=?", "#{current_user.id}" )
    @post= Post.create(post_params)
    if @post.valid?
      redirect_to "/users/#{current_user.id}/posts"
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to "/users/#{current_user.id}/posts/new"
    end

  end

  def new
    @post = Post.new
  end

  def show
    @posts = Post.where("user_id=?", "#{current_user.id}" )
  end

  def delete
    Post.find(params[:post_id]).destroy
    redirect_to "/users/#{current_user.id}/posts"
  end

  private
  def post_params
    params.require(:post).permit(:image, :description, :user_id, :review, :name)
  end
  def check_session
    if !session[:user_id]
      redirect_to '/'
    end
  end

end
