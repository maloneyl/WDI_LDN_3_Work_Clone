App.NavbarController = Ember.ObjectController.extend
  needs: ['auth'] # needs AuthController to be loaded
  currentUser: Em.computed.alias "controllers.auth.currentUser" # references info from AuthController to here and maintains live link between the two
  isAuthenticated: Em.computed.alias "controllers.auth.isAuthenticated"
  actions:
    logout: -> # we put the logout action here because the logout link is in the navbar
      log.info "NavbarController handling logout event..."
      @get("controllers.auth").logout()
