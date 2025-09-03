class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        Rails.logger.info "param: #{params}"
        Rails.logger.info "micropost_id param: #{params[:micropost_id]}"
        @comment.micropost_id = params[:comment][:micropost_id]

        if @comment.save
            flash[:success] = "Comment created!"
        else
            flash[:danger] = "Failed to create comment: #{@comment.errors}"
        end
        redirect_to request.referrer, status: :see_other
    end

  private
  def comment_params
    params.require(:comment).permit(:content, :micropost_id)
  end
end
