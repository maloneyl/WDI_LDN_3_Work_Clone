class AddPositionToQuantities < ActiveRecord::Migration
  def change
    add_column :quantities, :position, :integer
  end
end
