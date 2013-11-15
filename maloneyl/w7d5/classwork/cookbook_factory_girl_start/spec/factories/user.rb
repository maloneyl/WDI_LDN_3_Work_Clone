FactoryGirl.define do

  # LONG VERSION:
  # factory :my_awesome_user_factory, class: User do
  # end

  # SHORT VERSION A (works if sticking to naming convention):
  # factory :user do
  #   name "alice"
  #   email "alice@alice.com"
  #   password "password"
  #   role "user"
  # end

  # VERSION B: create multiple users later when we just do:
  # users = FactoryGirl.build_list :user, 3 # build just creates in memory
  # users = FactoryGirl.create_list :user, 3 # create gets things pushed to the db
  factory :user do
    sequence(:name) { |n| "user-#{n}"} # generates user-1, user-2, etc.
    email { "#{name}@email.com" } # generates user-1@email.com, user-2@email.com, etc.
    password "password"
    role "user"

    trait :with_recipes do
      ignore do # tell FactoryGirl below is NOT an attribute, otherwise if FactoryGirl.create :recipe, recipe_count: 5 will be treated as "recipe_count: 5" the table column data
        recipe_count 3
      end
      after(:create) do |user, evaluator| # evaluator gets us access to variables in ignore
        FactoryGirl.create_list :recipe_with_quantities, evaluator.recipe_count, user: user # we actually want :recipe_with_quantities instead of just :recipe
      end
    end

    factory :admin do # nested factory inherits from parent factory
      role "admin"
    end

    factory :chef do
      role "chef"
      factory :chef_with_recipes, traits: [:with_recipes]
    end

    factory :moderator do
      role "moderator"
    end

    factory :author do
      role "author"
      factory :author_with_recipes, traits: [:with_recipes] # because author has_many recipes
    end

    # EARLIER VERSION PRE-TRAITS:
    # factory :author do
    #   role "author"
    #   factory :author_with_recipes do # because author has_many recipes
    #     ignore do # tell FactoryGirl below is NOT an attribute, otherwise if FactoryGirl.create :recipe, recipe_count: 5 will be treated as "recipe_count: 5" the table column data
    #       recipe_count 3
    #     end
    #     after(:create) do |user, evaluator| # evaluator gets us access to variables in ignore
    #       FactoryGirl.create_list :recipe, evaluator.recipe_count, user: user
    #     end
    #   end
    # end

  end


end


# CONSOLE (VERSION A):
# .build -> creates in memory
# [4] pry(main)> u1 = FactoryGirl.build :user
# => #<User id: nil, name: "alice", email: "alice@alice.com", password_digest: "$2a$10$hP31uKieNpKadhpULdbREuVXhby721xTqumVfMnWmz2W...", role: "user">
# [5] pry(main)> u2 = FactoryGirl.build :user, role: "admin" # overwrite default role
# => #<User id: nil, name: "alice", email: "alice@alice.com", password_digest: "$2a$10$WpXVut4gdAmTAuHH8lEfGO.x0XXh4BeecXjA.X9UL3HO...", role: "admin">
# .create -> saves in db
# [6] pry(main)> u3 = FactoryGirl.create :user, role: "admin"
#    (0.9ms)  BEGIN
#   User Exists (4.4ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = 'alice@alice.com' LIMIT 1
#   SQL (5.4ms)  INSERT INTO "users" ("email", "name", "password_digest", "role") VALUES ($1, $2, $3, $4) RETURNING "id"  [["email", "alice@alice.com"], ["name", "alice"], ["password_digest", "$2a$10$Co../030vbdea/ZoAMd7r.CT9GM/Eu8N2z19sKFXknwUoHMNQBrHK"], ["role", "admin"]]
#    (2.0ms)  COMMIT
# => #<User id: 1, name: "alice", email: "alice@alice.com", password_digest: "$2a$10$Co../030vbdea/ZoAMd7r.CT9GM/Eu8N2z19sKFXknwU...", role: "admin">
