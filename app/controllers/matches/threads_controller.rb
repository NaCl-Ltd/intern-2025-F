class Matches::ThreadsController < ApplicationController
  before_action :logged_in_user
  before_action :set_match

  def create
    @thread = @match.forum_threads.build(thread_params)
    @thread.user = current_user # または system_user
    @thread.thread_type = :match # matchスレであることを明示

    if @thread.save
      flash[:success] = "試合スレッドを作成しました！"
      redirect_to @thread
    else
      flash[:danger] = "スレッドの作成に失敗しました。"
      redirect_to @match
    end
  end

  private

  def set_match
    @match = Match.find(params[:match_id])
  end

  def thread_params
    params.require(:forum_thread).permit(:title, :body) # bodyはPostに移動する可能性あり
  end
end