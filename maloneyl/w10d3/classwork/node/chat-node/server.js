// requirements for the application
var http = require("http");
var express = require("express"); // framework
var jade = require("jade"); // templating
var app = express(); // app is an instance of express
var server = http.createServer(app);
var io = require("socket.io").listen(server);

// opening connection
server.listen(3000);

// configuration parameters
app.set("views", __dirname + "/views"); // __dirname: current directory
app.set("view engine", "jade");
app.set("view options", {layout: false});

app.configure(function(){
  app.use(express.static(__dirname + "/public"));
})

// route-handling
app.get("/", function(req, res){
  res.render("home.jade");
})

io.sockets.on("connection", function(socket){ // refs io.connect() in script.js
  socket.on("setPseudo", function(data){
    socket.set("pseudo", data);
    console.log(data);
  })

  socket.on("message", function(message){
    socket.get("pseudo", function(error, name){
      var data = { "message": message, "pseudo": name }
      socket.broadcast.emit("message", data)
    })
  })

})
