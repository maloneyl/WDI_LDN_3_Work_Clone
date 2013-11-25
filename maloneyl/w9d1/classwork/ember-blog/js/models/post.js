App.Post = DS.Model.extend({
  title: DS.attr("string"),
  body: DS.attr("string"),
  posted: DS.attr("date")
  // comments: DS.hasMany("App.Comment")
})

App.Post.FIXTURES = [
  {id: 1, title: "First post", body: "Bacon ipsum dolor sit amet ad shankle shank hamburger. Pancetta pork belly voluptate, est beef ribs andouille esse dolor jerky. Nostrud ball tip reprehenderit ad mollit excepteur corned beef nulla exercitation venison voluptate salami. Capicola jowl filet mignon, cow pariatur cupidatat tail sed meatloaf.", posted: "2013-02-07T16:44:57.000Z"},
  {id: 2, title: "Second post", body: "Quis fugiat frankfurter, laboris leberkas ut excepteur shank eiusmod veniam ut pork chop flank hamburger beef ribs. Deserunt laborum in, drumstick kielbasa adipisicing culpa ribeye sirloin voluptate.", posted: "2013-03-10T18:24:59.000Z"},
  {id: 3, title: "Third post", body: "Prosciutto drumstick occaecat, tenderloin irure doner strip steak quis ad meatloaf anim sed. Tempor laboris andouille reprehenderit incididunt turducken, anim ut cillum corned beef.", posted: "2013-05-22T22:32:32.000Z"},
]
