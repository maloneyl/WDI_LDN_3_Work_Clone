class CreateQuantities < ActiveRecord::Migration
  def up
    create_table :quantities do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient
      t.string :description # for how to use this ingredient for this recipe
      t.decimal :price # for price of this ingredient for this recipe
      t.decimal :quantity
      t.string :measurement
      t.timestamps
    end
  end

  def down
    drop_table :quantities
  end
end
