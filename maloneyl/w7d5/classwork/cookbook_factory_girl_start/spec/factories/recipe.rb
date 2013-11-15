FactoryGirl.define do

  factory :recipe do
    # attributes
    sequence(:name) { |n| "recipe-#{n}" }
    course { %w(starter main dessert).sample }
    cooktime { rand(10..70) } # two dots means inclusive of last
    servingsize { rand(1..4) }
    instructions { Faker::Lorem.paragraph } # there's .sentence or .words too or .paragraph(num_of_paras)
    image { "#{name}-image.jpg" }

    # associations
    user

    factory :recipe_with_quantities do
      ignore do # ignore means not to treat as attributes
        quantity_count 5
      end

      after(:create) do |recipe, evaluator| # evaluator gives us access to 'ignore' vars
        FactoryGirl.create_list :quantity, evaluator.quantity_count, recipe: recipe
      end
    end

  end

end
