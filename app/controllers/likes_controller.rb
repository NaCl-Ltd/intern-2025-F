class LikesController < ApplicationController
  def create
    like = current_user.likes.build(micropost_id: params[:micropost_id])
    like.save
    redirect_to root_path
  end

  def destroy
    like = Like.find_by(micropost_id: params[:micropost_id], user_id: current_user.id)
    like.destroy
    redirect_to root_path, status: :see_other
  end
end
