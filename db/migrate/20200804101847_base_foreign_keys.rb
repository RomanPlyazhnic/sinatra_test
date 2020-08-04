class BaseForeignKeys < ActiveRecord::Migration[6.0]
  def up
    add_foreign_key :posts, :users, name: "fk_posts_users" ,on_delete: :cascade
    add_foreign_key :reviews, :posts, name: "fk_reviews_posts" ,on_delete: :cascade
  end

  def down
    remove_foreign_key :posts, name: "fk_posts_users"
    remove_foreign_key :reviews, name: "fk_reviews_posts"
  end
end
