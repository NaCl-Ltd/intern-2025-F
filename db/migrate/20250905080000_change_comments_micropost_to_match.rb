class ChangeCommentsMicropostToMatch < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :match, foreign_key: true
  end
end