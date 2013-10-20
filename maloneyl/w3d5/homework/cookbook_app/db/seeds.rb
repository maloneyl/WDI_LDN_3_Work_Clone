r1 = Recipe.create!(name: "Tomato and Zucchini Frittata", image: "http://1.bp.blogspot.com/-E13-J6ddsIE/UhOTzM-JcXI/AAAAAAAAL44/L-Nbj1x5sHQ/s1600/summer-tomato-zucchini-frittata.jpg", content: "Preheat oven to 400°F. Heat oil in a 10-inch skillet over medium-low heat. Stir in onion and cook until slightly golden, about 8 to 10 minutes. Add zucchini, increase heat to medium-high, season with salt and pepper and cook 2 to 3 minutes or until the moisture dries up, stirring occasionally. In a medium bowl whisk eggs, egg whites, Asiago, salt and pepper. Pour the eggs into the skillet making sure they cover all the vegetables. Arrange tomatoes in an overlapping pattern on top and season with salt and pepper. When the edges begin to set (about 2 minutes) move skillet to oven. Cook about 16 to 18 minutes, or until frittata is completely cooked. Serve warm, cut into 4 pieces.")
r2 = Recipe.create!(name: "Southwestern Black Bean Salad", image: "http://1.bp.blogspot.com/-mlXX1lXB-48/UX6Hda95osI/AAAAAAAALMU/nYqzuSvJPCE/s1600/Southwestern-Black-Bean-Salad.jpg", content: "In a large bowl, combine beans, corn, tomato, onion, scallion, cilantro, salt and pepper. Squeeze fresh lime juice to taste and stir in olive oil. Marinate in the refrigerator 30 minutes. Add avocado just before serving. Makes about 6 1/2 cups.")

i1 = Ingredient.create!(name: "tomato", image: "http://ateronon.saveonhealth.co.uk/files/Tomato.jpg")
i2 = Ingredient.create!(name: "zucchini", image: "http://www.wrensoft.com/zoom/demos/fruitshop/images/zucchini.jpg")
i3 = Ingredient.create!(name: "onion", image: "http://upload.wikimedia.org/wikipedia/commons/1/1b/Onions.jpg")
i4 = Ingredient.create!(name: "black bean", image: "http://img2.timeinc.net/health/images/slides/black-beans-challenge-400x400.jpg")
i5 = Ingredient.create!(name: "corn", image: "http://www.longfellow.org/wp-content/uploads/2013/07/Corn.jpg")

r1.ingredients = [i1, i2, i3]
r1.save
r2.ingredients = [i1, i3, i4, i5]
r2.save

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
