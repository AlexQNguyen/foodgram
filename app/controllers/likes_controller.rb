class LikesController < ApplicationController

  def show
    @likes = Like.where("user_id=?" , "#{current_user.id}")
    @posts = Post.all
  end

  def create
   @likes = Like.create(like_params)
   if @likes
     redirect_to "/users/#{current_user.id}/posts"
   else
     render json: @likes.errors
   end
  end

  def delete
   @unlike = Like.where("user_id=? and post_id=?", params[:user_id], params[:post_id])
   @unlike.destroy_all
   redirect_to "/users/#{current_user.id}/posts"
  end

   private
   def like_params
     params.require(:like).permit(:post_id, :user_id)
   end
end
