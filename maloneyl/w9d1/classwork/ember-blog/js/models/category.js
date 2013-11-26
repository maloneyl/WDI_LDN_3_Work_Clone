App.Category = DS.Model.extend({
  name: DS.attr("string"),
  post: DS.belongsTo("App.Post")
})

App.Category.FIXTURES = [
  {id: 1, name: "Geek", post: 1},
  {id: 2, name: "Music", post: 2},
  {id: 3, name: "Food", post: 3}
]
