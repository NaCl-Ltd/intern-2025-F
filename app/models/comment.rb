class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost, optional: true
  belongs_to :match, optional: true

  validate :micropost_or_match_present

  private

  def micropost_or_match_present
    unless micropost_id.present? || match_id.present?
      errors.add(:base, "micropost_idまたはmatch_idのいずれかが必要です")
    end
  end
end
