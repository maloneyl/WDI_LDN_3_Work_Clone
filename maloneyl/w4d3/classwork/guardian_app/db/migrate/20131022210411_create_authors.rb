class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :full_name
      t.text :bio
      t.date :birthdate

      t.timestamps
    end
  end
end
