class ClubsController < ApplicationController
  def index
    @clubs = Club.paginate(page: params[:page])
  end

  def show
    @club = Club.find(params[:id])
  end
end