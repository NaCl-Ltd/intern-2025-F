class Club < ApplicationRecord
  has_many :home_matches, class_name: "Match", foreign_key: "home_club_id", dependent: :destroy
  has_many :away_matches, class_name: "Match", foreign_key: "away_club_id", dependent: :destroy
  has_many :forum_threads, dependent: :destroy
  has_many :players, dependent: :destroy
end
