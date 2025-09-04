class AddFavoriteTeamToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :favorite_team, :string
  end
end
