CLASS NOTES
============


1. WEEKLY REVIEW
-----------------

translates getbootstrap.com/components/#navbar
``````````
%nav.navbar.navbar-default{role: :navigation}
  %li.active
     %a{href: "#"} Link
``````````

then to style that, you could custom-add:
````````````
nav.navbar.navbar-default {
  color: red;
}
``````````````

and if you don't want to use too much nesting, then do:
```````````````
%nav.navbar.navbar-default#header-menu{role: :navigation}
  %li.active
     %a{href: "#"} Link
````````````````
and in the css:
#header-menu 

the class can be passed as an attribute (which in turn uses a hash syntax), e.g.
````````
= image_tag painting.image_url(:thumb), {class: "img-circle"}
`````````

validation applies to db migration too
e.g. you can say: t.string :name, null:false
to make sure that the database doesn't save any entries that don't meet that validation


2. PROJECT PLANNING
--------------------

example: twitter better than twitter

FEATURES!

think about
must
o
should
ccould
o
would

e.g.
- a user must sign up to access
- a user should receive an email for confirmation
- a user would setup his profile details
- a user should be able to post a tweet
- a user should be able to reply to a tweet
- a user should be able to retweet
- a user should be able to go on a page showing a specific tweet
- a user should be able to see another person's profile
- a user should be able to modify the background image of his profile

user stories are useful because then you'll also be using them to do automated testing

trello board columns:
- to do
- doing
- bug
- tested
- deployed
- to archive
- ideas (extra features)

https://trello.com/b/ilUtqPv5/twitter-better-than-twitter


DATABASE!

sketch relationships
ref. rail's association basics (customers and orders)
http://guides.rubyonrails.org/association_basics.html#the-has-many-association
you'd write something like 1 --> infinity 


WIREFRAMING!

structure, not layout
balsamiq mockup, google base web wireframe
or just draw by hand!
site map, then individual views
