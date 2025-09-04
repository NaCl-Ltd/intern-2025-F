class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :forum_thread, counter_cache: false
  has_one_attached :image do |attachable|
  attachable.variant :display, resize_to_limit: [500, 500]
  end
  has_many :likes, dependent: :destroy
  has_many :comments
  default_scope -> { order(created_at: :desc) }
  scope :following, -> (user){ where(user: user.following) }
  scope :latest, -> (user){ following(user).where(created_at:(Time.zone.now-3600*48)..).order(created_at: :desc).limit(10) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                    message: "must be a valid image format" },
            size:         { less_than: 5.megabytes,
                    message:   "should be less than 5MB" }

  def liked_by?(user)
  likes.where(user_id: user.id).exists?
  end
end
