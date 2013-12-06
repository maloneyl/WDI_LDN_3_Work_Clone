var http = require("http");
// console.log("hello world");

http.createServer(function(request, response){
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("Hello World");
}).listen(3000, "0.0.0.0"); //port, IP


