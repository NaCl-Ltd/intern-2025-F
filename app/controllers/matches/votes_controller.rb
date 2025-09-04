class Matches::VotesController < ApplicationController
  before_action :logged_in_user
  before_action :set_match

  def new
    @vote = Vote.new
  end

  def create
    vote = Vote.find_or_initialize_by(
      user: current_user,
      votable: @match,
      category: "mom"

    )
    vote.player_id = params[:match_vote][:choice]
    vote.choice = params[:match_vote][:choice]
    if vote.save
      @mom_summary = Vote.where(votable: @match, category: "mom").group(:choice).count
      flash[:success] = "Vote recorded successfully."
      redirect_to match_path(@match)
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