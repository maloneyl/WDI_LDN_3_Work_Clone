QUESTIONS AND COMMENTS AFTER HOMEWORK
=======================================

* Homework location: w9d2/classwork/rails_ember_blog

* No blockers, though still not a fan of Ember. Was never entirely sure whether something would work until I tried it.


HOMEWORK
---------

Adding conditional edit/delete

While you wait for your project 2 feedback meeting, please use the the new cancan info passed by the API to conditionally show edit and delete links if a user is allowed to perform those actions.

Wire up the appropriate views/actions to make these links work.

Be sure to prompt the user with an "are you sure?" confirmation before performing a delete request.


CLASS NOTES
============

0. HOMEWORK REVIEW
-----------------------------------

see w9d2/classwork/rails_ember_blog


1. ADDING CANCAN
-----------------------------

also see see w9d2/classwork/rails_ember_blog


2. INTERNATIONALIZATION (I18N)
-------------------------------------------------

➜  maloneyl git:(w9d3-maloneyl) ✗ cd w9d3/classwork/cookbook_i18n_start
➜  cookbook_i18n_start git:(w9d3-maloneyl) ✗ rails c
Loading development environment (Rails 3.2.14)
[1] pry(main)> I18n.class
=> Module
[2] pry(main)> I18n.available_locales
=> [:en]
[3] pry(main)> I18n.locale # get default locale
=> :en
[4] pry(main)> I18n.backend
=> #<I18n::Backend::Simple:0x007fd1d6080fc0
 @initialized=true,
 @skip_syntax_deprecation=false,
 @translations=
  {:en=>
    {:date=>
      {:formats=>{:default=>"%Y-%m-%d", :short=>"%b %d", :long=>"%B %d, %Y"},
       :day_names=>
        ["Sunday",
         "Monday",
         "Tuesday",
         "Wednesday",
         "Thursday",
         "Friday",
         "Saturday"],
       :abbr_day_names=>["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
       :month_names=>
        [nil,
         "January",
         "February",
         "March",
         "April",
         "May",
         "June",
         "July",
         "August",
         "September",
         "October",
     etc. etc.
^-- includes things from gems too, e.g. will_paginate has its own labels for 'next', 'previous', etc.

app/config/locales/en.yml is the default from Rails
devise adds app/config/locales/devise.en.yml

these files should be named after country codes, so fr for France
e.g. fr.yml:
`````
fr:
  hello: "Bonjour tout le monde"
`````

and there's a gem to get all standard Rails messages
  gem 'rails-i18n', '~> 3.0.0'

[2] pry(main)> I18n.translate :hello
=> "Hello world"
[3] pry(main)> I18n.t :hello # shortcut
=> "Hello world"
[4] pry(main)> I18n.t "hello" # works with strings too
=> "Hello world"
[5] pry(main)> I18n.locale
=> :en
[6] pry(main)> I18n.locale = :fr
=> :fr
[7] pry(main)> I18n.t "hello" # no locale argument passed, returns default
=> "Bonjour tout le monde"
[10] pry(main)> I18n.t "hello", locale: :fr # pass explicit locale argument
=> "Bonjour tout le monde"
[11] pry(main)> I18n.t "hello", locale: :de
=> "translation missing: de.hello"
[12] pry(main)> I18n.t "hello", locale: :de, default: "hi" # set fallback value
=> "hi"

[13] pry(main)> I18n.t "date.day_names" # can chain to access nested: en - date - day_names
=> ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
[14] pry(main)> I18n.t("date.day_names")[0]
=> "Sunday"
[15] pry(main)> I18n.t("date.day_names", locale: :fr)[0]
=> "dimanche"

[16] pry(main)> I18n.t "datetime.distance_in_words.less_than_x_seconds"
=> {:one=>"less than 1 second", :other=>"less than %{count} seconds"
[17] pry(main)> I18n.t "datetime.distance_in_words.less_than_x_seconds", count: 1
=> "less than 1 second"
[18] pry(main)> I18n.t "datetime.distance_in_words.less_than_x_seconds", count: 2
=> "less than 2 seconds"
[19] pry(main)> I18n.t :less_than_x_seconds, count: 2, scope: [:datetime, :distance_in_words]
=> "less than 2 seconds"
[20] pry(main)> I18n.t [:x_seconds, :less_than_x_seconds], count: 2, scope: [:datetime, :distance_in_words] # even more usable
=> ["2 seconds", "less than 2 seconds"]

[21] pry(main)> I18n.localize Time.now, format: :long
=> "November 27, 2013 11:41"
[22] pry(main)> I18n.localize Time.now, format: :long, locale: :de
=> "Mittwoch, 27. November 2013, 11:41 Uhr"
[23] pry(main)> I18n.localize Time.now, format: :short
=> "27 Nov 11:42"
[24] pry(main)> I18n.localize Time.now, format: :short, locale: :de
=> "27. November, 11:42 Uhr"

[25] pry(main)> I18n.backend.store_translations :en, thanks: "Thanks, %{name}!"
=> (returns giant hash)
[26] pry(main)> I18n.t :thanks, name: "Jon"
=> "Thanks, Jon!"

in rails, the helper is t('the string to translate')
whatever is in the value is treated as the default
if we use English keys, we don't need to provide translations in English

but convention is to have it in lowercase symbols:
t("Cookbook") = t(:cookbook)
t("Sign up") = t(:sign_up)

instead of manually setting the locale, the simplest way is to lock that with a URL, e.g. en.wikipedia.org, de.wikipedia.org
implementing subdomains in our local host involves modifying the /etc/hosts file:
➜  cookbook_i18n_start git:(w9d3-maloneyl) ✗ subl /etc/hosts
ORIGINAL:
127.0.0.1 localhost
UPDATE TO:
127.0.0.1 en.localhost.local
127.0.0.1 fr.localhost.local
127.0.0.1 de.localhost.local

now we can go to http://fr.localhost.local:3000/ for French
http://de.localhost.local:3000/ and fall back to English
http://en.localhost.local:3000/ is still English

there's an ember-i18n gem too to import the giant hash of translations to the client-side


3. CAREER PREP
------------------------------------------

Deck: http://swipe.to/7746g
