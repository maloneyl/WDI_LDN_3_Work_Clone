function Item(description, status, options){

  var self = this;

  function initialize(description, status, options){
    self.description = description;
    self.status = status;

    defaultOptions = {
      priority: 1
    }
    _.extend(self, defaultOptions, options);
    // jQuery's equivalent: $.extend(self, defaultOptions, options);
  }

  initialize(description, status, options || {});
  return self;

}
