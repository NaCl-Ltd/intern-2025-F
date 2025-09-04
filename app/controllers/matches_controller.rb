class MatchesController < ApplicationController
    def show
        @match = Match.find(params[:id])
        @mom_summary = Vote.where(votable: @match, category: "mom").group(:choice).count
        @clubs = @match.clubs
        @home_club = @clubs[0]
        @away_club = @clubs[1]

        @comments = @match.comments
        @comment  = current_user.comments.build(match_id: @match.id)
    end

    def index
        @matches = Match.all.order(:kickoff_at)
    end

    def mom_results
        @match = Match.find(params[:id])
        @mom_summary = Vote.where(votable: @match, category: "mom").group(:choice).count
        render partial: 'matches/mom_results', locals: { mom_summary: @mom_summary }
    end

    def close_votes
        @match = Match.find(params[:id])
        # 投票締め切り処理（ジョブから呼び出される想定）
        # 例: MatchJob::CloseVotes.perform_later(@match.id)
        head :ok
    end
end