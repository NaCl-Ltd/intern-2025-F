class CreateClubs < ActiveRecord::Migration[7.0]
  def change
    create_table :clubs do |t|
      t.string :name, null: false
      t.string :short_name
      t.string :crest_url
      t.string :stadium
      t.string :color_hex
      t.timestamps
    end
    add_index :clubs, :name, unique: true
  end
end
