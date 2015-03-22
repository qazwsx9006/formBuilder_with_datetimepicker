class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.datetime :published_at
      t.date :published_date

      t.timestamps null: false
    end
  end
end
