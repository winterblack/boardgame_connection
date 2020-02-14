class CreateBoardgames < ActiveRecord::Migration[5.2]
  def change
    create_table :boardgames do |t|
      t.integer :geek_id, unique: true
      t.string :thumbnail
      t.string :image
      t.string :name, index: { unique: true }
      t.integer :year, index: true
      t.integer :min_players, index: true
      t.integer :max_players, index: true
      t.integer :play_time, index: true
      t.float :geek_rating, index: true
      t.integer :geek_rank, index: true
      t.timestamps
    end
  end
end
