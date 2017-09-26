class SessionsController < ApplicationController
  def register
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id]= @user.id
      redirect_to "/users/#{current_user.id}/posts"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/'
    end
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id]= @user.id
      redirect_to "/users/#{current_user.id}/posts"
    else
      redirect_to '/users/login' , notice: "Invaild Login"
    end

  end

  def logout
    session.delete(:user_id)
    redirect_to '/'
  end
  private
  def user_params
      params.require(:user).permit(:user_name, :first_name, :last_name, :email, :password, :password_confirmation)
  end

end
