class CreateUsersClubs < ActiveRecord::Migration
  def self.up
    create_table :clubs_users, :id => false, :force => true do |t|
        t.integer :club_id
        t.integer :user_id
        t.timestamps
      end
  end

  def self.down
    drop_table :clubs_users
  end
end

