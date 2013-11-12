class CreateGdps < ActiveRecord::Migration
  def change
    create_table :gdps do |t|
      t.string :quarter
      t.decimal :qoq_growth

      t.timestamps
    end
  end
end

# ➜  uk_gdp_app git:(w7d2-maloneyl) ✗ rake db:migrate
# ==  CreateGdps: migrating =====================================================
# -- create_table(:gdps)
#    -> 0.0033s
# ==  CreateGdps: migrated (0.0034s) ============================================
