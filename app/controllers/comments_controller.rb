class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        Rails.logger.info "Creating comment with micropost_id: #{@comment.micropost_id}, match_id: #{@comment.match_id}"

        # どちらか一方があればセット
        if params[:comment][:micropost_id].present?
            @comment.micropost_id = params[:comment][:micropost_id]
        else
            @comment.micropost_id = nil
        end

        if params[:comment][:match_id].present?
            @comment.match_id = params[:comment][:match_id]
        else
            @comment.match_id = nil
        end

        # どちらもなければエラー
        unless @comment.micropost_id.present? || @comment.match_id.present?
            flash[:danger] = "micropost_idまたはmatch_idのいずれかが必要です"
            return redirect_to request.referrer, status: :see_other
        end

        if @comment.save
            flash[:success] = "Comment created!"
        else
            flash[:danger] = "Failed to create comment: #{@comment.errors.full_messages.to_sentence}"
        end
        redirect_to request.referrer, status: :see_other
    end

  private
  def comment_params
    params.require(:comment).permit(:content, :micropost_id, :match_id)
  end
end
