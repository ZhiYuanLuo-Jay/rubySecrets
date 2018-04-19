class SecretsController < ApplicationController
  before_action :require_login

  def index
    @secrets = Secret.all
  end

  def create
    @user = User.find(params[:id])
    @secret = Secret.new(content: params[:content], user_id: params[:id])
    # @user = User.new(params.require(:user).permit(:username))
    if @secret.valid?
      @secret.save
    else
      flash[:errors] = @secret.errors.full_messages 
    end
    redirect_to "/users/#{@user.id}"
  end 

  def destroy
    secret = Secret.find(params[:id])
    if secret.user == current_user
      secret.destroy
    end
    # secret.destroy
    redirect_to "/users/#{session[:user_id]}" 
  end 

end
