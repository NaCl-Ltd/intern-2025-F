class ChangeMatchIdNullOnComments < ActiveRecord::Migration[7.0]
  def change
    change_column_null :comments, :match_id, true
  end
end