// CONSTRUCTOR FUNCTION
// basically just creates a new empty object: this = {};
// then adds key-and-value pairs based on what's given: this.x = something, this.y = somethingElse
// then returns the completed this
// BUT before we even start, we should
// - lock the value of this by assigning it to self (or _this)
// - make sure it's 'var self = this' instead of 'self = this'...

function Item(description, status, options){

  var self = this; // MUST-do

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
