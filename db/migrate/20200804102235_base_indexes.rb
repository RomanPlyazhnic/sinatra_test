class BaseIndexes < ActiveRecord::Migration[6.0]
  def up
    add_index :users, [:login], name: "by_login", unique: true
    add_index :posts, [:avg_rating], name: "by_avg_rating"
    add_index :posts, [:user_ip], name: "by_ip_address", using: "gist", opclass: :inet_ops
    add_index :reviews, [:mark], name: "by_mark"    
  end

  def down
    remove_index :users, name: "by_login"
    remove_index :posts, name: "by_avg_rating"
    remove_index :posts, name: "by_ip_address"
    remove_index :reviews, name: "by_mark"
  end
end
