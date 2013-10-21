class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate
    end

    create_table :movies_actors, id: false do |t|
      t.integer :movie_id
      t.integer :actor_id
    end
  end
end
