class CreateForumThreads < ActiveRecord::Migration[7.0]
  def change
  create_table :forum_threads do |t|
    t.string :title, null: false
    t.integer :thread_type, null: false, default: 0  # enum { club:0, match:1, news:2 }
    t.references :user,  null: false, foreign_key: true
    t.references :club,  foreign_key: true
    t.references :match, foreign_key: true
    t.boolean :pinned, default: false
    t.boolean :closed, default: false
    t.datetime :last_commented_at
    t.timestamps
  end
  add_index :forum_threads, :thread_type
  end
end
