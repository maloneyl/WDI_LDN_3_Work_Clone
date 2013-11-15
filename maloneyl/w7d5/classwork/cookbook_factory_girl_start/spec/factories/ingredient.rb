FactoryGirl.define do

  factory :ingredient do
    sequence(:name) { |n| "ingredient-#{n}"}
    image { "#{name}-image.jpg" } # for carrierwave, check its docs for how to handle things like this
  end

end
