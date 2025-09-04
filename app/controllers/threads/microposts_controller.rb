class Threads::MicropostsController < ApplicationController
  before_action :logged_in_user
  before_action :set_forum_thread

  def index
  @microposts = @forum_thread.microposts.order(:created_at)
  @micropost = @forum_thread.microposts.build
  end

  def create
  @micropost = @forum_thread.microposts.build(micropost_params)
  @micropost.user = current_user

  if @micropost.save
    # Turbo Streamで新着投稿を自動差し込み
    # render turbo_stream: turbo_stream.append("microposts", partial: "microposts/micropost", locals: { micropost: @micropost })
    flash[:success] = "投稿しました！"
    redirect_to @forum_thread
  else
    @microposts = @forum_thread.microposts.order(:created_at)
    render 'threads/show', status: :unprocessable_entity
  end
  end

  private

  def set_forum_thread
  @forum_thread = ForumThread.find(params[:thread_id])
  end

  def micropost_params
  params.require(:micropost).permit(:content, :parent_micropost_id) # contentはMicropostのbodyに相当
  end
end