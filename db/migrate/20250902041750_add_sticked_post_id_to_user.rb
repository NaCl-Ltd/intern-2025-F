class AddStickedPostIdToUser < ActiveRecord::Migration[7.0]
  def change
  add_column :users, :sticked_post_id, :integer
  end
end
