class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.string  :category, null: false   # "MOM" など
      t.references :votable, polymorphic: true, null: false  # Match を想定
      t.references :user, null: false, foreign_key: true
      t.string  :choice, null: false     # 選手名（将来 player_idに置換可）
      t.timestamps
    end
    add_index :votes, [:category, :votable_type, :votable_id, :user_id], unique: true, name: "uniq_vote"
  end
end
