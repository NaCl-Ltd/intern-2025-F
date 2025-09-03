class Vote < ApplicationRecord
    belongs_to :votable, polymorphic: true
    belongs_to :user
    validates :category, inclusion: { in: %w[mom] }
    validates :choice, presence: true
    validates :user_id, uniqueness: { scope: [:category, :votable_type, :votable_id] }
end
