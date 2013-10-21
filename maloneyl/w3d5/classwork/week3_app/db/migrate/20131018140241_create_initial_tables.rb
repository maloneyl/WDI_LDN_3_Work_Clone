class CreateInitialTables < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
      t.string :name
      t.string :phone
    end

    create_table :lists do |t|
      t.string :name
    end

    create_table :contacts_lists do |t|
      t.integer :contact_id
      t.integer :list_id
    end
  end

  def down
    drop_table :contacts
    drop_table :lists
    drop_table :lists_contacts
  end
end
