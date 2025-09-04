ranges = (68..73).to_a
user_ids = User.pluck(:id).sample(130) # 既存ユーザーからランダムに130件取得

user_ids.each do |user_id|
    p "user_id: ", user_id
  choice = ranges.sample
  vote = Vote.find_or_initialize_by(
    user_id: user_id,
    votable_id: 23,
    votable_type: "Match",
    category: "mom"
  )
  vote.player_id = choice
  vote.choice = choice
  vote.save!
end