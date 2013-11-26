Ember.Handlebars.helper 'format-markdown', (input) -> # name of helper, (parameter)

  # initate it and stash it away
  window.showdown ?= new Showdown.converter() # we can do this because we have showdown.js loaded

  new Handlebars.SafeString(showdown.makeHtml(input)) # treat whatever output as safe (i.e. there's no script tag, can be rendered without need to escape anything)

Ember.Handlebars.helper 'format-date', (date) ->
  moment(date).fromNow() # we have moment.js loaded too and it's got a fromNow method that does "...ago"

# Ember.Handlebars.helper 'display-both-dates', (date_posted, date_modified) ->
#   if date_posted != date_modified then true else false
