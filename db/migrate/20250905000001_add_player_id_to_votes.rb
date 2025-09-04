class AddPlayerIdToVotes < ActiveRecord::Migration[7.0]
  def change
    add_column :votes, :player_id, :integer
  end
end
