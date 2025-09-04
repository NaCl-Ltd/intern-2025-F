class Match < ApplicationRecord
    enum status: { scheduled: 0, live: 1, ft: 2 }
    belongs_to :home_club, class_name: "Club"
    belongs_to :away_club, class_name: "Club"
    has_many :forum_threads
    has_many :votes, as: :votable
    scope :upcoming, -> { scheduled.where("kickoff_at > ?", Time.current).order(:kickoff_at) }
    after_create_commit :schedule_open_live_job, if: :scheduled?
    after_update_commit :schedule_close_votes_job, if: :ft?

    private

    def schedule_open_live_job
      MatchJob::OpenLiveJob.set(wait_until: kickoff_at).perform_later(id)
    end

    def schedule_close_votes_job
      MatchJob::CloseVotesJob.set(wait_until: kickoff_at + 24.hours).perform_later(id)
    end
end
