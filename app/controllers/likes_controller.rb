class LikesController < ApplicationController
  before_action :require_login

  def create
    # fail
    Like.create(user: current_user, secret:Secret.find(params[:id]))
    # Like.create(user: current_user, secret_id: params[:id])
    redirect_to "/secrets"
  end

  def destroy
    like = Like.find_by(secret: Secret.find(params[:id]), user: current_user )
    # find_by good for obj, where not used for obj
    like.destroy
    redirect_to "/secrets"
  end

end
