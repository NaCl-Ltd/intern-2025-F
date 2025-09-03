class MatchesController < ApplicationController
    def show
        @match = Match.find(params[:id])
        @thread = @match.forum_threads.find_or_create_by!(thread_type: :match, user: system_user) do |thread|
            thread.title = "#{@match.home_club.short_name} vs #{@match.away_club.short_name} - Match Discussion"
        end
        @mom_summary = Vote.where(votable: @match, category: "mom").group(:choice).count
    end

    def index
        @matches = Match.all.order(:kickoff_at)
    end

    def mom_results
        @match = Match.find(params[:id])
        @mom_summary = Vote.where(votable: @match, category: "mom").group(:choice).count
        # Turbo Streamで集計結果を更新する想定
        render partial: 'matches/mom_results', locals: { mom_summary: @mom_summary }
    end

    def close_votes
        @match = Match.find(params[:id])
        # 投票締め切り処理（ジョブから呼び出される想定）
        # 例: MatchJob::CloseVotes.perform_later(@match.id)
        head :ok
    end
end