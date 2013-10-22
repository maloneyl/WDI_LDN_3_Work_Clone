Recipe.delete_all
Ingredient.delete_all

r1 = Recipe.create(:name => 'Banana Pancakes', :course => 'Dessert', :cooktime => 10, :servingsize => 4, :instructions => 'Cook in pan', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps1053_BB2406671D07_20_3b.jpg')
r2 = Recipe.create(:name => 'French Chicken', :course => 'Main', :cooktime => 125, :servingsize => 3, :instructions => 'Heat Oven', :image => 'http://img4-3.myrecipes.timeinc.net/i/recipes/ck/96/11/french-chicken-ck-222717-l.jpg')
r3 = Recipe.create(:name => 'French Onion Soup', :course => 'Apps', :cooktime => 35, :servingsize => 1, :instructions => '', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps36687_HC1154010B12_06_1b.jpg')

i1 = Ingredient.create(:name => 'Flour', :image => 'http://3.bp.blogspot.com/_Iel3IXJ_g7A/RzIFHOZyqRI/AAAAAAAACvk/f6zlHQ_QFSA/s400/flour.jpg')
i2 = Ingredient.create(:name => 'Eggs',  :image => 'http://images.elephantjournal.com/wp-content/uploads/2010/04/eggs1.jpg')
i3 = Ingredient.create(:name => 'Sugar', :image => 'http://verifiedafricanmango.com/wp-content/uploads/2012/08/Sugar.jpg')
i4 = Ingredient.create(:name => 'Milk', :image => 'http://images.wisegeek.com/pitcher-of-milk.jpg')
i5 = Ingredient.create(:name => 'Butter', :image => 'http://www.cheesemaking.com/images/recipes/35Butter/Pics/pic51.jpg')
i6 = Ingredient.create(:name => 'Bacon', :image => 'http://4.bp.blogspot.com/-HX7l3B-dPXY/UN0FeGidWHI/AAAAAAAADZE/FF9svNR700I/s1600/crispy-bacon.jpg')


q1 = Quantity.create(recipe_id: r1.id,ingredient_id: i1.id,description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",price: 3.21 ,quantity: "100" ,measurement: "gr")
q2 = Quantity.create(recipe_id: r1.id,ingredient_id: i2.id,description: "Proin dapibus mi et tellus dictum pharetra",price: 23.54 ,quantity: 2 ,measurement: "pieces")
q3 = Quantity.create(recipe_id: r1.id,ingredient_id: i5.id,description: "Proin dapibus mi et tellus dictum pharetra",price: 23.54 ,quantity: 50 ,measurement: "gr")
q4 = Quantity.create(recipe_id: r2.id,ingredient_id: i6.id,description: "Fusce volutpat vel nunc a volutpat. Pellentesque habitant morbi tristique senectus",price: 10.54 ,quantity: 50 ,measurement: "gr")