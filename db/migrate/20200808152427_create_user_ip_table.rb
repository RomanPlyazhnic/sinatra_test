class CreateUserIpTable < ActiveRecord::Migration[6.0]
  def up
    create_table :userips do |t|
      t.string :user_login
      t.cidr :user_ip
      t.integer :user_id
    end

    add_foreign_key :userips, :users, name: "fk_user_ips_users" ,on_delete: :cascade
    add_index :userips, [:user_id, :user_ip], name: "by_user_id_user_ip"
  end

  def down
    remove_index :userips, name: "by_user_id_user_ip"
    remove_foreign_key :userips, name: "fk_user_ips_users"
    drop_table :userips    
  end
end
