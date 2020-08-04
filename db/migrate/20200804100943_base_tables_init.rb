class BaseTablesInit < ActiveRecord::Migration[6.0]
  def up
    create_table :users do |t|
      t.string :login
    end

    create_table :posts do |t|
      t.string :title
      t.text :content
      t.float :avg_rating
      t.cidr :user_ip
      t.integer :user_id      
    end

    create_table :reviews do |t|
      t.integer :mark
      t.integer :post_id
    end
  end

  def down
    drop_table :users
    drop_table :posts
    drop_table :reviews
  end
end
