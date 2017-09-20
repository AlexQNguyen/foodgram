class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    @post= Post.create(post_params)


  end

  def new
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
