class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.integer :jersey_number
      t.string :nationality
      t.integer :age

      t.timestamps
    end
  end
end
