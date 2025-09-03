class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @comment.save
        redirect_back(fallback_location: root_path)
    end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
