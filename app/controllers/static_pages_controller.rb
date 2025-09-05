class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      Rails.logger.info "Current user's sticked_post_id: #{current_user.sticked_post_id}"
      Rails.logger.info "Current user's sticked_post: #{Micropost.find(current_user.sticked_post_id)}"
      @sticked_micropost = Micropost.find(current_user.sticked_post_id)
      @feed_items = current_user.feed.paginate(page: params[:page])
      @likes = Like.all
      @comments = Comment.all
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
