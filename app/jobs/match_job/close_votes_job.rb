class MatchJob::CloseVotesJob < ApplicationJob
  queue_as :default

  def perform(match_id)
    match = Match.find_by(id: match_id)
    return unless match

    # 投票を締め切るロジック
    # 例: 投票を受け付けないようにMatchモデルにフラグを追加するか、
    # Voteモデルに投票期間のバリデーションを追加する
    # 今回は、単にログを出力するのみ
    Rails.logger.info "Match #{match.id} MOM voting closed."

    # 結果をForumThread先頭に固定メッセージとして投稿
    system_user = User.first # または適切なシステムユーザーを取得
    forum_thread = match.forum_threads.find_by(thread_type: :match)
    if forum_thread
      mom_summary = Vote.where(votable: match, category: "mom").group(:choice).count
      top_mom = mom_summary.max_by { |choice, count| count }
      message = if top_mom
                  "MOM投票結果：#{top_mom[0]}選手が#{top_mom[1]}票でMOMに選ばれました！"
                else
                  "MOM投票は行われませんでした。"
                end
      
      # Micropostとして投稿
      forum_thread.microposts.create!(user: system_user, content: message)
    end
  end
end