class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.date :date_value
      t.decimal :usd
      t.decimal :gbp
      t.decimal :jpy
    end
  end
end
