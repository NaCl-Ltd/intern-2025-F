class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :home_club, null: false, foreign_key: { to_table: :clubs }
      t.references :away_club, null: false, foreign_key: { to_table: :clubs }
      t.datetime :kickoff_at, null: false
      t.integer  :round
      t.string   :venue
      t.string   :referee
      t.integer  :status, default: 0, null: false  # enum { scheduled:0, live:1, ft:2 }
      t.timestamps
    end
    add_index :matches, [:home_club_id, :away_club_id, :kickoff_at]
  end
end
