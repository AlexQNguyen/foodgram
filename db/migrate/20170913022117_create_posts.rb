class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :description
      t.text :review
      t.text :name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
