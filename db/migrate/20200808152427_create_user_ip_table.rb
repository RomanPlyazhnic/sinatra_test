class CreateUserIpTable < ActiveRecord::Migration[6.0]
  def up
    create_table :userips do |t|
      t.string :user_login
      t.cidr :user_ip
      t.integer :user_id
    end

    add_foreign_key :userips, :users, name: "fk_user_ips_users" ,on_delete: :cascade
    add_index :userips, [:user_ip, :user_id], name: "by_user_ip_user_id"
  end

  def down
    remove_index :userips, name: "by_user_ip_user_id"
    remove_foreign_key :userips, name: "fk_user_ips_users"
    drop_table :userips    
  end
end
