class AddClubIdToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_reference :players, :club, foreign_key: true, null: false
  end
end