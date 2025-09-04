class ChangeMicropostIdNullOnComments < ActiveRecord::Migration[7.0]
  def change
    change_column_null :comments, :micropost_id, true
  end
end