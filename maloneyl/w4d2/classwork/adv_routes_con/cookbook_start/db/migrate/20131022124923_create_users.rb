class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest # you don't save passwords directly; need encryption
      t.string :role
    end
  end

  def down
    drop_table :users
  end
end
