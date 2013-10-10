COMMENTS & QUESTIONS AFTER HOMEWORK
=====================================

- It's great to see that Ruby app from last week come together by mixing in things we learned in the last few days
- No real questions apart from more CSS styles to google and experiment on my own
- Been running into stupid issues because of syntax and other errors that are not second nature yet because of all the different 'languages' we've been learning, e.g. with Sinatra, how we get the params, how the params we get are strings, how once we go back into CSS we must remember the semi-colons, etc.


CLASS NOTES
============

0. HOMEWORK REVIEW
******************

text-transform: uppercase

you can include a few fonts under "font-family" so that the browser will look through them

margin: 20px 10px 5px 0px
-> 20px top, 10px right, 5px bottom, 0px left

margin: 20px
-> 20px all four dimensions

margin: 20px 10px:
-> 20px top and bottom, 10px left and right

margin: 0 auto;

&copy;
-> copyright symbol

&amp;
-> ampersand

a:hover, a:visited
-> this is called pseudo-selector


1. OSI MODEL
*************

OSI Model
= open-system interconnections

switch/hub
-> connects a number of computers

router
-> connects a number of switches; dispatch traffic among different switches

HOST LAYERS
- application layer, e.g. SMTP/POP in email, HTTP in websites in our browsers
- presentation layer, e.g. still STMP, POP, HTTP, etc. but behind-the-scenes
- session layer: responsible for attributing the right port because different protocols use different ports to communicate (e.g. port 25 for POP/SMTP, port 80 for http://www.google.com:80, port 443 for https://www.google.com:443)
- transport layer: TCP (transmission control protocol): receiving and sending packets, transfer to media layers

MEDIA LAYERS
- network layer: ipv4, ipv6; every computer has an IP (ipv4 schema: 0-255.0-255.0-255.0-255, i.e. 2**32=4 billion IP addresses available… soon to run out because these days there are too many computers, hence the move from ipv4 to ipv6; ipv6 gives you 2**128 addresses now)
- data link layer: ethernet, 802.11
- physical layer: Adsl, isdn, rs+x

http request
= requesting a resource from a specific location

when you type www.google.com in your browser, that request goes to a DNS (domain name system) server. any website URL -- any domain name -- is just a masked version of an IP. the DNS server resolves the URL and gets the right IP. the IP then goes to another server where that data is and returns this data, transforms that TCP data into something visual…

Chrome's developer tool > Network > Headers
"request headers": what's sent to google when we request that site: we do a http request and we get a http response ("response headers")… status: 200 ok, 404 not found

html header -> stuff above
html head, html body -> the stuff we see and code

http://generalassembl.ly/wdi/london/ldn-3.html?data_asked=students#jack
-> http:// is the protocol
-> generalassembl.ly is the domain, mask of the IP
-> /wdi/london/ldn-3.html is the path
-> ?data_asked=students is the parameter
-> #jack is the hash

http://en.wikipedia.org/wiki/Barack_Obama#U.S._Senate_campaign
-> en.wikipedia.org is the domain (en is the subdomain)
-> /wiki/Barack_Obama is the path
-> #U.S._Senate_campaign is the hash

https://twitter.com/search?q=general%20assembly&src=typd
-> ?q=general%20assembly&src=typd are the parameters
the structure is always .../page?key=value&key2=value2

twitter.com/profile
-> GET method to get twitter.com -- read
vs. POST -- send/create
and other http verbs we should know:
UPDATE
DELETE
basically 4 http verbs for our database actions CRUD
REST = representational state transfer

if you type this in shell (curl is a software that makes manual http requests):
curl -X POST http://www.twitter.com
curl -X GET http://www.twitter.com
you'll see different responses


2. SINATRA
**********

Sinatra is good-enough for small projects, no need for Rails

localhost is the alias for 0.0.0.0, your default local IP

------------
require 'sinatra'
require 'sinatra/contrib/all'

get "/hi" do 
  "Hello world"
end
-----------
➜  sinatra git:(w2d3-maloneyl) ✗ ruby hi.rb
[2013-10-09 11:11:39] INFO  WEBrick 1.3.1
[2013-10-09 11:11:39] INFO  ruby 2.0.0 (2013-06-27) [x86_64-darwin12.5.0]
== Sinatra/1.4.3 has taken the stage on 4567 for development with backup from WEBrick
etc. etc.

http://localhost:4567/hi

let's add some parameters:
--------------
get "/firstname/:param_firstname" do
  "Hello, #{params[:param_firstname]}"
end
-------------
--> now if you go on http://localhost:4567/firstname/baloney, you see "Hello, baloney"!

let's add some more parameters:
--------------
get "/name/:first/:last/:age" do
  "Your name is #{params[:first]} #{params[:last]}. Your age is #{params[:age]}."
end
-------------
--> now if you go on http://localhost:4567/name/maloney/baloney/20, you see "Your name is maloney baloney. Your age is 20."

if you'd rather not do two different string interpolation for the params above, you can place the params as an array then do join with a space: #{[params[:first], params[:last]].join(" ")}

------------
get "/multiply/:x/:y" do
  (params[:x].to_f * params[:y].to_f).to_s
end
------------
http://localhost:4567/multiply/5/2
-> 10.0

model view controller:
we submit a request to the controller
controller - a ruby file - that instantiates a new model, which then dedicates the job of finding the db
go to the db
gets back the db
go back to the controller
the controller instantiates a new view (html)
get that html to return to us

.erb
-> embedded ruby

inside an erb file, indicate ruby code with this set of tags:
<%= %>


*****this is calc.erb*****
<html>
<head>
  <title>My first Sinatra website</title>
</head>
<body>
  <p>The result is <%= @result %></p>
</body>
</html>
*****
get "/multiply/:x/:y" do
  @result = params[:x].to_f * params[:y].to_f
  erb :calc
end
------
http://localhost:4567/multiply/5/2
-> The result is 10.0

Sinatra's magic is that whatever's in a public folder is automatically accessible through root

layout.erb is what Sinatra looks for default as the layout
you can, of course, specify your own (e.g. in the above, where we use calc.erb instead of layout.erb)
and if you delete calc.erb, it'll automatically load layout.erb instead

if you include "p params" in your rb file, it'll print the params in the terminal

your session is linked to the cookies you have on your computer
you can keep your session for as long as you keep your cookies

enable :sessions
