QUESTIONS AND COMMENTS AFTER HOMEWORK
======================================

* No real issues, just took a long time to spot typos, missing parentheses/curly braces and such because of the lack of error messages.
* It could be confusing at first to know what should be replaced by jQuery and what shouldn't, how it works with JS or whether certain JS functions/methods can still be used with it, etc.
* It took me many google results before I came across a good explanation for how to use a wildcard selector. Not sure if it's just the quality of the docs/answers I found or if it's a sign that I really don't know enough JS/jQuery yet. But glad to have things sorted eventually.
* I've noticed that I still don't quite understand whether my variables should be $something, var $something, something or var something.
* Still wondering how to make the onchange method work more than once… Is there a way to make the unit labels switch back and forth with the dropdown change? 
* Also wondered if we're expected to keep the getValue and getFloat methods because we do use these methods a lot. But both methods seem easy and short enough with jQuery already, and having to artificially generate something like "'#' + someID + ''" seems strange/confusing (or is there a better way to do this?).

HOMEWORK
---------

Tonight’s task is to refactor yesterday’s Calculator app... using jQuery! 

CLASS NOTES
============

1. JQUERY
----------------

query simplifies and normalizes API
helps support multiple browsers much more easily

for instance, window.onload does different things in different browsers
jquery helps with loading and setup
- load the document structure
- do a bunch of setup, e.g. associate handler code with events
- perform initial actions, e.g. run initial code

jQuery helps with browser events

jQuery 1.x for IE 6-8
jQuery 2.x for normal browsers

gem 'jquery-rails' already included by default
javasript_include_tag 'application'' is where we load it

help:
http://api.jquery.com

typeof jQuery
"function"

jQuery.[lots of functions!]
and in jQuery, jQuery has the shorthand $
this means we can do $.[function]
$ == jQuery
true

see examples and notes in classwork/examples_start/main.js
