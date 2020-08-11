class PostIndexIpUser < ActiveRecord::Migration[6.0]
  def up
    remove_index :posts, name: "by_ip_address"
    add_index :posts, [:user_ip, :user_id], name: "by_user_ip_user_id_posts"
  end

  def down    
    add_index :posts, [:user_ip], name: "by_ip_address", using: "gist", opclass: :inet_ops
    remove_index :posts, name: "by_user_ip_user_id"  
  end
end
