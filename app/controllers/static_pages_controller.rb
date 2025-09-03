class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @sticked_micropost = Micropost.find_by(id: current_user.sticked_post_id) if current_user.sticked_post_id?
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
