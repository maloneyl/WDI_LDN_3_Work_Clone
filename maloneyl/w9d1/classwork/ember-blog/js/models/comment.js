App.Comment = DS.Model.extend({
  message: DS.attr("string"),
  posted: DS.attr("date"),
  post: DS.belongsTo("App.Post")
})

App.Comment.FIXTURES = [
  {id: 1, message: "Cool beans.", posted: "2013-02-07T17:50:25.000Z", post: 1},
  {id: 2, message: "Just trolling.", posted: "2013-03-11T14:32:25.000Z", post: 2},
  {id: 3, message: "Here is another comment to test stuff.", posted: "2013-05-24T10:22:05.000Z", post: 3}
]
