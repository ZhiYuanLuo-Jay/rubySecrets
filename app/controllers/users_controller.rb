class UsersController < ApplicationController
  before_action :require_login, :check_user, except: [:new, :create]
  
  def new
  end

  def show
    # fail
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    # @user = User.new(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to sessions_new_path
      # redirect_to "/secrets"
    else
      #errors we need to code later
      flash[:errors] = @user.errors.full_messages 
      redirect_to users_new_path
    end
  end 

  def update
    usr = User.find(params[:id])
    
    # if usr.update(name: params[:name], email: params[:email])
    if usr.update(user_edit_params)
      redirect_to "/users/#{usr.id}"
    else
      flash[:errors] = ["Email is invalid"]
      redirect_to "/users/#{usr.id}/edit"
    end 
  end 

  def destroy
    usr = User.find(params[:id])
    usr.destroy
    session[:user_id] = nil
    redirect_to "/users/new"
  end 


  private 
  
  def user_edit_params
   params.require(:user).permit(:name, :email)
  end
 
  def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Add a filter to the UsersController that makes sure that the id stored in session,
  # matches the id being passed into params. If the ids do not match, redirect that user to his own show page. 
  # before_action :check_user, except: [:new, :create]
  def check_user
    usr = User.find(session[:user_id])
    if params[:id].to_i != session[:user_id]
      redirect_to "/users/#{usr.id}"
    end 
  end

end
