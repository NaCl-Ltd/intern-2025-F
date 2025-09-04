class MatchJob::OpenLiveJob < ApplicationJob
  queue_as :default

  def perform(match_id)
  match = Match.find_by(id: match_id)
  return unless match && match.scheduled?

  # 試合状態をliveに更新
  match.live!

  # ライブ用スレッドを自動作成
  # system_userはApplicationControllerで定義されていると仮定
  system_user = User.first # または適切なシステムユーザーを取得
  forum_thread = match.forum_threads.find_or_create_by!(thread_type: :match, user: system_user) do |thread|
    thread.title = "#{match.home_club.name} vs #{match.away_club.name} ライブスレッド"
  end

  # 告知通知（例: ActionCableでリアルタイム通知、またはメール通知など）
  # ActionCable.server.broadcast "matches:#{match.id}", { message: "ライブスレッドがオープンしました！", thread_id: forum_thread.id }
  Rails.logger.info "Match #{match.id} is now live. Forum thread #{forum_thread.id} created."
  end
end