class CreateLibraries < ActiveRecord::Migration
  def up
    create_table :libraries do |t|
      t.string :name
      t.string :address   
    end 
  end

  def down
    drop_table :libraries
  end
end
