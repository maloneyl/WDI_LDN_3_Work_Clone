# the view file is used to tell Ember the name of the template to use
# otherwise, especially with our flat structure, Ember won't be able to guess that the template is named posts_new (instead of posts/new)

App.PostsNewView = Ember.View.extend
  templateName: 'posts_new'
