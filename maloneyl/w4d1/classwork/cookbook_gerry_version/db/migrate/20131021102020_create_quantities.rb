class CreateQuantities < ActiveRecord::Migration
  def up
    create_table :quantities do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient
      t.string :description
      t.decimal :price
      t.decimal :quantity
      t.string :measurement
      t.timestamps
    end
  end

  def down
    drop_table :quantities
  end
end
