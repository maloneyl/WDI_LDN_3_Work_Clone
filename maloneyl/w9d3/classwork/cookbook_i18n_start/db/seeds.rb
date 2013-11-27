User.delete_all
Recipe.delete_all
Ingredient.delete_all
Quantity.delete_all

u1 = User.create!(name: 'Alice', role: 'admin', email: 'alice@alice.com', password: 'password', password_confirmation: 'password')
u2 = User.create!(name: 'Bob', role: 'author', email: 'bob@bob.com', password: 'password', password_confirmation: 'password')
u3 = User.create!(name: 'Charlie', role: 'author', email: 'charlie@charlie.com', password: 'password', password_confirmation: 'password')
u4 = User.create!(name: 'Daisy', role: nil, email: 'daisy@daisy.com', password: 'password', password_confirmation: 'password')

u4 = User.create!(name: 'Eric', role: 'moderator', email: 'eric@eric.com', password: 'password', password_confirmation: 'password')
u5 = User.create!(name: 'Fred', role: 'chef', email: 'fred@fred.com', password: 'password', password_confirmation: 'password')

r1 = Recipe.new(:name => 'Banana Pancakes', :course => 'Dessert', :cooktime => 10, :servingsize => 4, :instructions => 'Cook in pan', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps1053_BB2406671D07_20_3b.jpg')
r2 = Recipe.new(:name => 'French Chicken', :course => 'Main', :cooktime => 125, :servingsize => 3, :instructions => 'Heat Oven', :image => 'http://img4-3.myrecipes.timeinc.net/i/recipes/ck/96/11/french-chicken-ck-222717-l.jpg')
r3 = Recipe.new(:name => 'French Onion Soup', :course => 'Apps', :cooktime => 35, :servingsize => 1, :instructions => '', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps36687_HC1154010B12_06_1b.jpg')
r4 = Recipe.new(:name => 'Banana Pancakes', :course => 'Dessert', :cooktime => 10, :servingsize => 4, :instructions => 'Cook in pan', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps1053_BB2406671D07_20_3b.jpg')
r5 = Recipe.new(:name => 'French Chicken', :course => 'Main', :cooktime => 125, :servingsize => 3, :instructions => 'Heat Oven', :image => 'http://img4-3.myrecipes.timeinc.net/i/recipes/ck/96/11/french-chicken-ck-222717-l.jpg')
r6 = Recipe.new(:name => 'French Onion Soup', :course => 'Apps', :cooktime => 35, :servingsize => 1, :instructions => '', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps36687_HC1154010B12_06_1b.jpg')
r7 = Recipe.new(:name => 'Banana Pancakes', :course => 'Dessert', :cooktime => 10, :servingsize => 4, :instructions => 'Cook in pan', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps1053_BB2406671D07_20_3b.jpg')
r8 = Recipe.new(:name => 'French Chicken', :course => 'Main', :cooktime => 125, :servingsize => 3, :instructions => 'Heat Oven', :image => 'http://img4-3.myrecipes.timeinc.net/i/recipes/ck/96/11/french-chicken-ck-222717-l.jpg')
r9 = Recipe.new(:name => 'French Onion Soup', :course => 'Apps', :cooktime => 35, :servingsize => 1, :instructions => '', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps36687_HC1154010B12_06_1b.jpg')
r10 = Recipe.new(:name => 'Banana Pancakes', :course => 'Dessert', :cooktime => 10, :servingsize => 4, :instructions => 'Cook in pan', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps1053_BB2406671D07_20_3b.jpg')
r11 = Recipe.new(:name => 'French Chicken', :course => 'Main', :cooktime => 125, :servingsize => 3, :instructions => 'Heat Oven', :image => 'http://img4-3.myrecipes.timeinc.net/i/recipes/ck/96/11/french-chicken-ck-222717-l.jpg')
r12 = Recipe.new(:name => 'French Onion Soup', :course => 'Apps', :cooktime => 35, :servingsize => 1, :instructions => '', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps36687_HC1154010B12_06_1b.jpg')
r13 = Recipe.new(:name => 'Banana Pancakes', :course => 'Dessert', :cooktime => 10, :servingsize => 4, :instructions => 'Cook in pan', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps1053_BB2406671D07_20_3b.jpg')
r14 = Recipe.new(:name => 'French Chicken', :course => 'Main', :cooktime => 125, :servingsize => 3, :instructions => 'Heat Oven', :image => 'http://img4-3.myrecipes.timeinc.net/i/recipes/ck/96/11/french-chicken-ck-222717-l.jpg')
r15 = Recipe.new(:name => 'French Onion Soup', :course => 'Apps', :cooktime => 35, :servingsize => 1, :instructions => '', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps36687_HC1154010B12_06_1b.jpg')
r16 = Recipe.new(:name => 'Banana Pancakes', :course => 'Dessert', :cooktime => 10, :servingsize => 4, :instructions => 'Cook in pan', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps1053_BB2406671D07_20_3b.jpg')
r17 = Recipe.new(:name => 'French Chicken', :course => 'Main', :cooktime => 125, :servingsize => 3, :instructions => 'Heat Oven', :image => 'http://img4-3.myrecipes.timeinc.net/i/recipes/ck/96/11/french-chicken-ck-222717-l.jpg')
r18 = Recipe.new(:name => 'French Onion Soup', :course => 'Apps', :cooktime => 35, :servingsize => 1, :instructions => '', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps36687_HC1154010B12_06_1b.jpg')
r19 = Recipe.new(:name => 'Banana Pancakes', :course => 'Dessert', :cooktime => 10, :servingsize => 4, :instructions => 'Cook in pan', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps1053_BB2406671D07_20_3b.jpg')
r20 = Recipe.new(:name => 'French Chicken', :course => 'Main', :cooktime => 125, :servingsize => 3, :instructions => 'Heat Oven', :image => 'http://img4-3.myrecipes.timeinc.net/i/recipes/ck/96/11/french-chicken-ck-222717-l.jpg')
r21 = Recipe.new(:name => 'French Onion Soup', :course => 'Apps', :cooktime => 35, :servingsize => 1, :instructions => '', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps36687_HC1154010B12_06_1b.jpg')
r22 = Recipe.new(:name => 'Banana Pancakes', :course => 'Dessert', :cooktime => 10, :servingsize => 4, :instructions => 'Cook in pan', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps1053_BB2406671D07_20_3b.jpg')
r23 = Recipe.new(:name => 'French Chicken', :course => 'Main', :cooktime => 125, :servingsize => 3, :instructions => 'Heat Oven', :image => 'http://img4-3.myrecipes.timeinc.net/i/recipes/ck/96/11/french-chicken-ck-222717-l.jpg')
r24 = Recipe.new(:name => 'French Onion Soup', :course => 'Apps', :cooktime => 35, :servingsize => 1, :instructions => '', :image => 'http://hostedmedia.reimanpub.com/TOH/Images/Photos/37/exps36687_HC1154010B12_06_1b.jpg')

r1.user = u2; r1.save!
r2.user = u3; r2.save!
r3.user = u3; r3.save!
r4.user = u2; r4.save!
r5.user = u3; r5.save!
r6.user = u3; r6.save!
r7.user = u2; r7.save!
r8.user = u3; r8.save!
r9.user = u3; r9.save!
r10.user = u2; r10.save!
r11.user = u3; r11.save!
r12.user = u3; r12.save!
r13.user = u2; r13.save!
r14.user = u3; r14.save!
r15.user = u3; r15.save!
r16.user = u2; r16.save!
r17.user = u3; r17.save!
r18.user = u3; r18.save!
r19.user = u2; r19.save!
r20.user = u3; r20.save!
r21.user = u3; r21.save!
r22.user = u2; r22.save!
r23.user = u3; r23.save!
r24.user = u3; r24.save!

i1 = Ingredient.create!(:name => 'Flour', :image => 'http://3.bp.blogspot.com/_Iel3IXJ_g7A/RzIFHOZyqRI/AAAAAAAACvk/f6zlHQ_QFSA/s400/flour.jpg')
i2 = Ingredient.create!(:name => 'Eggs',  :image => 'http://images.elephantjournal.com/wp-content/uploads/2010/04/eggs1.jpg')
i3 = Ingredient.create!(:name => 'Sugar', :image => 'http://verifiedafricanmango.com/wp-content/uploads/2012/08/Sugar.jpg')
i4 = Ingredient.create!(:name => 'Milk', :image => 'http://images.wisegeek.com/pitcher-of-milk.jpg')
i5 = Ingredient.create!(:name => 'Butter', :image => 'http://www.cheesemaking.com/images/recipes/35Butter/Pics/pic51.jpg')
i6 = Ingredient.create!(:name => 'Bacon', :image => 'http://4.bp.blogspot.com/-HX7l3B-dPXY/UN0FeGidWHI/AAAAAAAADZE/FF9svNR700I/s1600/crispy-bacon.jpg')


q1 = Quantity.create!(recipe_id: r1.id,ingredient_id: i1.id,description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",price: 3.21 ,quantity: "100" ,measurement: "gr")
q2 = Quantity.create!(recipe_id: r1.id,ingredient_id: i2.id,description: "Proin dapibus mi et tellus dictum pharetra",price: 23.54 ,quantity: 2 ,measurement: "pieces")
q3 = Quantity.create!(recipe_id: r1.id,ingredient_id: i5.id,description: "Proin dapibus mi et tellus dictum pharetra",price: 23.54 ,quantity: 50 ,measurement: "gr")
q4 = Quantity.create!(recipe_id: r2.id,ingredient_id: i6.id,description: "Fusce volutpat vel nunc a volutpat. Pellentesque habitant morbi tristique senectus",price: 10.54 ,quantity: 50 ,measurement: "gr")