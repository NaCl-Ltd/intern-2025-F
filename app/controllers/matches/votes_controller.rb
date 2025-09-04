class Matches::VotesController < ApplicationController
  before_action :logged_in_user
  before_action :set_match

  def create
  vote = Vote.find_or_initialize_by(user: current_user, votable: @match, category: "mom")
  vote.choice = params[:choice]
  if vote.save
    # Turbo Streamで集計パーシャルを差し替え
    @mom_summary = Vote.where(votable: @match, category: "mom").group(:choice).count
    render turbo_stream: turbo_stream.replace("mom_results", partial: "matches/mom_results", locals: { mom_summary: @mom_summary })
  else
    render json: { errors: vote.errors.full_messages }, status: :unprocessable_entity
  end
  end

  def update
  create # createと同じロジックで更新も行う
  end

  private

  def set_match
  @match = Match.find(params[:match_id])
  end
end