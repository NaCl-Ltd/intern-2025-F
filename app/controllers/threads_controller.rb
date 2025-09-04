class ThreadsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]

  def index
  @threads = ForumThread.all.order(last_commented_at: :desc)
  end

  def show
  @thread = ForumThread.find(params[:id])
  @posts = @thread.posts.order(:created_at)
  @post = @thread.posts.build # 新規投稿用
  end

  def create
  @thread = current_user.forum_threads.build(thread_params)
  if @thread.save
    flash[:success] = "スレッドを作成しました！"
    redirect_to @thread
  else
    render 'new' # newビューはまだ作成していないが、一旦
  end
  end

  private

  def thread_params
  params.require(:forum_thread).permit(:title, :thread_type, :club_id, :match_id)
  end
end