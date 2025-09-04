class ForumThread < ApplicationRecord
    enum thread_type: { club: 0, match: 1, news: 2 }
    belongs_to :user
    belongs_to :club, optional: true
    belongs_to :match, optional: true
    has_many :microposts, dependent: :destroy
end
