class SessionsController < ApplicationController
  before_action :require_login, except: [:new, :create]
  
  def new
    # render login page
  end
  
  def create
    # Log User In
    # Retrieve user instance by email and password, if true user instance returened
    @usr = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    p @usr
    if @usr 
      session[:user_id] = @usr.id
      redirect_to "/users/#{@usr.id}"
    else
      flash[:errors] = ['Invalid Combination']
      redirect_to "/sessions/new"
    end 
  end

  def destroy
      # Log User out
      session[:user_id] = nil
      redirect_to "/sessions/new"
  end

end


# def create
#   usr = params[:user][:username]
#   #  usr = params[:user]['username']     #same as above

#   if User.where(username: usr).empty?
#     @user = User.new(params.require(:user).permit(:username))
#     if @user.save
#       # p @user.username
#       flash[:notice] = ['Welcome ' + @user.username]
#       p session[:user_id] = @user.id
#       redirect_to messages_path
#     else
#       #errors we need to code later
#       flash[:notice] = @user.errors.full_messages 
#       redirect_to users_new_path
#     end
#   else 
#     u1 = User.where(username: usr)
#     session[:user_id] = u1[0].id
#     session[:username] = u1[0].username
#     redirect_to messages_path
#   end 
# end