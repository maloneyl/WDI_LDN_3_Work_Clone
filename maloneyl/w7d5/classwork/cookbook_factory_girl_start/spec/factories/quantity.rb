FactoryGirl.define do

  factory :quantity do # note our quantity model has attributes and associations
    # attributes
    description { Faker::Lorem.sentence }
    price { rand(1..5) }
    quantity { rand(1..4) }
    measurement { %w(kg g tsps pcs).sample }

    # associations (ref: ingredient_id and recipe_id)
    ingredient # this means create an ingredient (as specified in our ingredient factory) then associate this new ingredient with our new quantity
    recipe
  end

end
